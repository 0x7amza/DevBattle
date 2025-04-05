import 'package:devbattle/api/user_api.dart';
import 'package:devbattle/constants/colors.dart';
import 'package:devbattle/widgets/Dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:devbattle/utils/token.dart';
import 'package:devbattle/screens/navbar_screen.dart';

class VerificationScreen extends StatefulWidget {
  final String email;
  const VerificationScreen({super.key, required this.email});
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  Future<void> _verifyOtp() async {
    String otpCode = '';
    for (var controller in controllers) {
      otpCode += controller.text;
    }
    if (otpCode.isEmpty) {
      showErrorDialog("Please enter a valid OTP.", context);
      return;
    }

    try {
      var result = await UserApi.verifyOTP(widget.email, otpCode);
      var token = result['token'];
      print(token);
      await TokenStorage.saveToken(token);

      var profile = await UserApi.getProfile(token);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder:
              (context) => NavbarScreen(
                statistics: profile['statistics'],
                user: profile['user'],
              ),
        ),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      showErrorDialog(e.toString(), context);
    }
  }

  List<TextEditingController> controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  bool isSubmitEnabled = false;

  @override
  void initState() {
    super.initState();

    for (var controller in controllers) {
      controller.addListener(() {
        setState(() {
          isSubmitEnabled = controllers.every(
            (controller) => controller.text.isNotEmpty,
          );
        });
      });
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: 360,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 360),
                  Image.asset('assets/images/logo.png', width: 100),
                  SizedBox(height: 10),

                  Text(
                    'Verify your email Address',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'By entering the code received',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 30),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(6, (index) => buildOtpField(index)),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  for (var controller in controllers) {
                    if (controller.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('fill all fields')),
                      );
                      return;
                    }
                  }
                  _verifyOtp();
                },
                child: Container(
                  width: 140,
                  height: 60,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  decoration: BoxDecoration(
                    color: PrimeryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'Submit',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "What's this? ",
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Learn More',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOtpField(int index) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (RawKeyEvent event) {
        if (event.isKeyPressed(LogicalKeyboardKey.backspace)) {
          if (controllers[index].text.isEmpty && index > 0) {
            focusNodes[index - 1].requestFocus();
          }
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        width: 50,
        height: 60,
        child: TextField(
          controller: controllers[index],
          focusNode: focusNodes[index],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 1,
          decoration: InputDecoration(
            counterText: '',
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (value) {
            if (value.isNotEmpty && index < 5) {
              // تحويل التركيز إلى الحقل التالي إذا كان هناك أرقام جديدة
              focusNodes[index + 1].requestFocus();
            } else if (value.isEmpty && index > 0) {
              // تحويل التركيز إلى الحقل السابق إذا تم حذف الرقم
              focusNodes[index - 1].requestFocus();
            }
          },
          onSubmitted: (value) {
            if (index == 5 && value.isNotEmpty) {
              // إذا كان الحقل الأخير ممتلئًا، قم بتوجيه التركيز إلى الزر Submit
              submitCode();
            } else if (value.isEmpty && index > 0) {
              // إذا كان الحقل فارغًا وتم الضغط على "Submit"، انتقل إلى الحقل السابق
              focusNodes[index - 1].requestFocus();
            }
          },
        ),
      ),
    );
  }

  void submitCode() {
    String otpCode = controllers.map((controller) => controller.text).join('');
    print('OTP Code: $otpCode');

    // هنا يمكنك إرسال الرمز للتحقق
    //например: verifyOtp(otpCode);
  }
}
