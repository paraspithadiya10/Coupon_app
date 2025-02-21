import 'dart:async';
import 'package:demo_app/screens/home_screen.dart';
import 'package:demo_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  static const String keyLogin = "login";

  @override
  void initState() {
    super.initState();
    whereToGo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff484453),
      body: Center(
        child: Icon(
          Icons.person_2_sharp,
          size: 100,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> whereToGo() async {
    var sharedPref = await SharedPreferences.getInstance();

    var isLogedIn = sharedPref.getBool(keyLogin);

    Timer(Duration(seconds: 2), () {
      if (isLogedIn != null) {
        if (isLogedIn) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        }
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
  }
}
