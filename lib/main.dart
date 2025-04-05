import 'package:devbattle/api/user_api.dart';
import 'package:devbattle/screens/login_screen.dart';
import 'package:devbattle/screens/navbar_screen.dart';
import 'package:devbattle/utils/token.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      home: SelectionArea(child: SplashScreen()),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      checkLoginStatus(context);
    });
  }

  void checkLoginStatus(BuildContext context) async {
    var token = await TokenStorage.getToken();
    if (token != null) {
      try {
        var profile = await UserApi.getProfile(token);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) => NavbarScreen(
                  statistics: profile['statistics'],
                  user: profile['user'],
                ),
          ),
        );
        return;
      } catch (e) {
        print('Error fetching profile: $e');
      }
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SelectionArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Reet Code',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 20),
              CircularProgressIndicator(color: Colors.green),
            ],
          ),
        ),
      ),
    );
  }
}
