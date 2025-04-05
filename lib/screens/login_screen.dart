import 'dart:convert';
import 'dart:typed_data';
import 'package:devbattle/api/user_api.dart';
import 'package:devbattle/constants/colors.dart';
import 'package:devbattle/screens/verification_screen.dart';
import 'package:devbattle/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:devbattle/widgets/Dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Uint8List? _imageBytes;
  String? _qrCodeResult;

  Future<void> _loginUser(email) async {
    if (email.isEmpty) {
      showErrorDialog("Please enter a valid email.", context);
      return;
    }
    try {
      var result = await UserApi.login(email);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerificationScreen(email: email),
        ),
      );
    } catch (e) {
      showErrorDialog(e.toString(), context);
    }
  }

  Future<void> _registerUser(url) async {
    if (url.isEmpty) {
      showErrorDialog("Please enter a valid URL.", context);
      return;
    }
    try {
      var result = await UserApi.signup(url);
      // push to otp screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerificationScreen(email: result['email']),
        ),
      );
    } catch (e) {
      showErrorDialog(e.toString(), context);
    }
  }

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      Uint8List imageBytes = result.files.first.bytes!;
      String? qrCode = await _scanQRCode(imageBytes);
      if (qrCode != null) {
        _registerUser(qrCode);
      } else {
        print("No QR Code Found");
      }
    }
  }

  Future<String?> _scanQRCode(Uint8List imageBytes) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.1.9:3000/scan-qr'),
      );

      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          imageBytes,
          filename: 'image.jpg',
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(responseBody);
        if (jsonResponse['isQrFound'] == true) {
          return jsonResponse['qrCode'];
        }
      } else {
        print("Failed to scan QR Code. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred while scanning QR Code: $e");
    }
    return null;
  }

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mediaQuery query = mediaQuery(context);
    return SelectionArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SizedBox(
            width: query.getWidth() * 40,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 10),
                Image.asset('assets/images/logo.png', width: 100),
                SizedBox(height: 10),
                Text(
                  'Reet Code',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),

                Text(
                  'Graduate with better coding skills',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: query.getWidth() * 40,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'University Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    String email = emailController.text;
                    if (email.isEmpty) {
                      showErrorDialog("Please enter a valid email.", context);
                      return;
                    }
                    _loginUser(email);
                  },
                  child: Container(
                    width: query.getWidth() * 40,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    decoration: BoxDecoration(
                      color: PrimeryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    _pickImage();
                  },
                  child: Container(
                    width: query.getWidth() * 40,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[400]!),
                    ),
                    child: Center(
                      child: Text(
                        'Scan ID Instead',
                        style: TextStyle(fontSize: 16, color: BlackColor),
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
      ),
    );
  }
}
