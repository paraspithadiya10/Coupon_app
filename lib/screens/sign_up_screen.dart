import 'package:demo_app/data/local/db_helper.dart';
import 'package:demo_app/widgets/social_buttons_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  DbHelper? dbRef;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dbRef = DbHelper.getInstance;
  }

  void proceedSignUp() async {
    // Check if user already exists
    final existingUsers = await dbRef!.getAllUsers();
    final userExists =
        existingUsers.any((user) => user['email'] == emailController.text);

    if (userExists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User with this email already exists'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      // Add new user and navigate to login
      await dbRef!.addUser(
          username: nameController.text,
          email: emailController.text,
          password: passwordController.text);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: height * 1.0,
        child: Stack(
          children: [
            Positioned(
              top: height * 0.03,
              child: SizedBox(
                height: height * 1.0,
                child: SvgPicture.asset(
                  width: width,
                  'assets/images/signup_background_2nd_layer.svg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.27,
              child: SvgPicture.asset(
                width: width,
                'assets/images/signup_background_1st_layer.svg',
                fit: BoxFit.fill,
              ),
            ),
            screenNameSocialButtonsAndFormUI(
                width,
                height,
                context,
                nameController,
                emailController,
                passwordController,
                confirmPasswordController,
                formKey)
          ],
        ),
      ),
    );
  }

  Widget screenNameSocialButtonsAndFormUI(
      double width,
      double height,
      BuildContext context,
      nameController,
      emailController,
      passwordController,
      confirmPasswordController,
      formKey) {
    return SingleChildScrollView(
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: width * 0.10,
                  top: height * 0.07,
                  bottom: height * 0.04),
              child: Text(
                'Create\nAccount',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 45),
              ),
            ),
            socialButtonsUI(width),
            Container(
                padding:
                    EdgeInsets.only(left: 35, top: height * 0.04, right: 35),
                child: formTextFieldsUI(
                    context,
                    nameController,
                    emailController,
                    passwordController,
                    confirmPasswordController,
                    height,
                    formKey)),
          ],
        ),
      ),
    );
  }

  Widget socialButtonsUI(double width) {
    return Padding(
      padding: EdgeInsets.only(left: width * 0.09),
      child: Row(
        spacing: 20,
        children: [
          SocialButtonsWidget(
            imagePath: 'assets/images/facebook_logo.png',
            backgroundColor: Colors.white,
            borderColor: Color(0xff3B5998),
          ),
          SocialButtonsWidget(
            imagePath: 'assets/images/google_logo.png',
            backgroundColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget formTextFieldsUI(context, nameController, emailController,
      passwordController, confirmPasswordController, height, formKey) {
    return Form(
      key: formKey,
      child: Column(
        spacing: 30,
        children: [
          TextFormField(
            controller: nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Name is required';
              }
              if (value.length < 5) {
                return 'Name must be at least 5 characters long';
              }
              return null;
            },
            decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.white)),
          ),
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
                    .copyWith(color: Colors.white)),
          ),
          TextFormField(
            controller: passwordController,
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
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.white),
            ),
          ),
          TextFormField(
            controller: confirmPasswordController,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Confirm Password is required';
              }
              if (value != passwordController.text) {
                return "Passwords doesn't match";
              }
              if (value.length < 8) {
                return 'Password must be at least 8 characters long';
              }
              return null;
            },
            decoration: InputDecoration(
                labelText: 'Confirm Password',
                labelStyle: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.white)),
          ),
          textAndButtonUI(context, nameController, emailController,
              passwordController, formKey),
          SizedBox(height: 20),
          signInButtonUI(context),
          SizedBox(
            height: height * 0.1,
          )
        ],
      ),
    );
  }

  Widget textAndButtonUI(BuildContext context, nameController, emailController,
      passwordController, formKey) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Sign up',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        CircleAvatar(
          radius: 40,
          backgroundColor: Color(0xff484453),
          child: IconButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  proceedSignUp();
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

  Widget signInButtonUI(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text(
              'Sign in',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  decoration: TextDecoration.underline,
                  color: Colors.white,
                  decorationColor: Colors.white),
            )),
      ],
    );
  }
}
