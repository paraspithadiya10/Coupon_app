import 'package:demo_app/data/preferences/pref_keys.dart';
import 'package:demo_app/providers/user_provider.dart';
import 'package:demo_app/screens/home_screen.dart';
import 'package:demo_app/widgets/login_header_graphics.dart';
import 'package:demo_app/widgets/social_buttons_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:demo_app/widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> currentUser = [];

  @override
  void initState() {
    super.initState();
  }

  Future<bool> isUserAvailable() async {
    currentUser = await context
        .read<UserProvider>()
        .getUser(emailController.text, passwordController.text);

    return currentUser.isNotEmpty;
  }

  void doLogin() async {
    // User found, proceed with login
    var sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setBool(keyLogin, true);
    await sharedPref.setInt(keyUserId, currentUser.first['id']);

    if (!mounted) return;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  Future<void> handleLogin() async {
    if (await isUserAvailable()) {
      doLogin();
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid email or password'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            LoginHeaderGraphicsWidget(),
            _socialAuthOptionsUI(),
            loginFormUI(height, context)
          ],
        ),
      ),
    );
  }

  Widget _socialAuthOptionsUI() {
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

  Widget _textAndArrowButtonUI() {
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
                  await handleLogin();
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

  Widget _signUpAndForgotPasswordButtonsUI() {
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

  Widget loginFormUI(height, context) {
    final labelColor =
        Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.grey);
    return Container(
      padding: EdgeInsets.only(left: 35, top: height * 0.08, right: 35),
      child: Form(
        key: _formKey,
        child: Column(
          spacing: 30,
          children: [
            CustomTextFormField(
              controller: emailController,
              labelText: 'Email',
              labelColor: labelColor,
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
            ),
            CustomTextFormField(
              controller: passwordController,
              labelText: 'Password',
              labelColor: labelColor,
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                }
                if (value.length < 8) {
                  return 'Password must be at least 8 characters long';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            _textAndArrowButtonUI(),
            SizedBox(height: 20),
            _signUpAndForgotPasswordButtonsUI()
          ],
        ),
      ),
    );
  }
}
