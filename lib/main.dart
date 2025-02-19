import 'package:demo_app/screens/detail_screen.dart';
import 'package:demo_app/screens/discover_screen.dart';
import 'package:demo_app/screens/home_screen.dart';
import 'package:demo_app/screens/login_screen.dart';
import 'package:demo_app/screens/sign_up_screen.dart';
import 'package:demo_app/screens/splash_screen.dart';
import 'package:demo_app/utils/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DemoApp());
}

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      initialRoute: '/splash_screen',
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routes: {
        '/splash_screen': (context) => SplashScreen(),
        '/login_screen': (context) => LoginScreen(),
        '/signup_screen': (context) => SignUpScreen(),
        '/home_screen': (context) => HomeScreen(),
        '/discover_Screen': (context) => DiscoverScreen(),
        '/detail_Screen': (context) => DetailScreen()
      },
    );
  }
}
