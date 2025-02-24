import 'package:demo_app/data/local/db_helper.dart';
import 'package:demo_app/data/preferences/pref_keys.dart';
import 'package:demo_app/screens/home_screen.dart';
import 'package:demo_app/widgets/social_buttons_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  DbHelper? dbRef;
  final _formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> user = [];

  @override
  void initState() {
    super.initState();
    dbRef = DbHelper.getInstance;
  }

  Future<bool> isUserAvailable() async {
    user = await dbRef!.getUser(
        emailController.text.toString(), passwordController.text.toString());

    return user.isNotEmpty;
  }

  void doLogin() async {
    // User found, proceed with login
    var sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setBool(keyLogin, true);
    await sharedPref.setInt(keyUserId, user.first['id']);

    if (!mounted) return;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            headerGraphicsUI(width, height),
            socialAuthOptionsUI(),
            Container(
                padding:
                    EdgeInsets.only(left: 35, top: height * 0.08, right: 35),
                child: loginFormUI()),
          ],
        ),
      ),
    );
  }

  Widget headerGraphicsUI(double width, double height) {
    return SizedBox(
      width: width * 1.0,
      height: height * 0.27,
      child: Stack(children: [
        SvgPicture.asset(
          width: width,
          'assets/images/login_background_1st_layer.svg',
          fit: BoxFit.fill,
        ),
        Positioned(
            right: 0,
            child: SvgPicture.asset(
              'assets/images/login_background_3rd_layer.svg',
              width: width * 0.40,
              height: height * 0.25,
              fit: BoxFit.fill,
            )),
        SvgPicture.asset(
          width: width,
          'assets/images/login_background_2nd_layer.svg',
          fit: BoxFit.fill,
        ),
        Padding(
          padding: EdgeInsets.only(left: width * 0.15, top: height * 0.08),
          child: Text(
            'Welcome\nBack',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 40),
          ),
        ),
      ]),
    );
  }

  Widget socialAuthOptionsUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 35, top: 25),
      child: Row(
        spacing: 20,
        children: [
          SocialButtonsWidget(
            imagePath: 'assets/images/facebook_logo.png',
            borderColor: Color(0xff3B5998),
          ),
          SocialButtonsWidget(
            imagePath: 'assets/images/google_logo.png',
            borderColor: Color(0xff4285F4),
          ),
        ],
      ),
    );
  }

  Widget textAndArrowButtonUI() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Sign in',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        CircleAvatar(
          radius: 40,
          backgroundColor: Color(0xff484453),
          child: IconButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  if (await isUserAvailable()) {
                    doLogin();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Invalid email or password'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              icon: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              )),
        )
      ],
    );
  }

  Widget signUpAndForgotPasswordButtonsUI() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/signup_screen');
          },
          child: Text(
            'Sign up',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(decoration: TextDecoration.underline),
          ),
        ),
        Text(
          'Forgot Password',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(decoration: TextDecoration.underline),
        ),
      ],
    );
  }

  Widget loginFormUI() {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 30,
        children: [
          TextFormField(
            controller: emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email is required';
              }
              if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                  .hasMatch(value)) {
                return 'Invalid email address';
              }
              return null;
            },
            decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.grey)),
          ),
          TextFormField(
            controller: passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password is required';
              }
              if (value.length < 8) {
                return 'Password must be at least 8 characters long';
              }
              return null;
            },
            obscureText: true,
            decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.grey)),
          ),
          SizedBox(height: 20),
          textAndArrowButtonUI(),
          SizedBox(height: 20),
          signUpAndForgotPasswordButtonsUI()
        ],
      ),
    );
  }
}
