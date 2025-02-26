import 'package:demo_app/providers/user_provider.dart';
import 'package:demo_app/widgets/social_buttons_widget.dart';
import 'package:demo_app/widgets/svg_picture_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_app/widgets/custom_text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void proceedSignUp() async {
    final existingUsers = context.read<UserProvider>().getAllUsers();
    final userExists =
        existingUsers.any((user) => user['email'] == emailController.text);

    final userNameExists =
        existingUsers.any((user) => user['username'] == nameController.text);

    if (!mounted) return;

    if (userExists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User with this email already exists'),
          backgroundColor: Colors.red,
        ),
      );
    } else if (userNameExists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This username is not available, please try to change'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      await context.read<UserProvider>().addUser(
          nameController.text, emailController.text, passwordController.text);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Account created successfully!'),
        backgroundColor: const Color.fromARGB(255, 51, 177, 55),
      ));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SizedBox(
        height: height * 1.0,
        child: Stack(
          children: [
            Positioned(
              top: height * 0.03,
              child: SizedBox(
                height: height * 1.0,
                child: SvgPictureWidget(
                  width: width,
                  imagePath: 'assets/images/signup_background_2nd_layer.svg',
                ),
              ),
            ),
            SizedBox(
              height: height * 0.27,
              child: SvgPictureWidget(
                width: width,
                imagePath: 'assets/images/signup_background_1st_layer.svg',
              ),
            ),
            _buildMainContent(
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

  Widget _buildMainContent(
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
            _socialButtonsUI(width),
            Container(
                padding:
                    EdgeInsets.only(left: 35, top: height * 0.04, right: 35),
                child: _buildSignUpFormUI(
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

  Widget _socialButtonsUI(double width) {
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

  Widget _buildSignUpFormUI(context, nameController, emailController,
      passwordController, confirmPasswordController, height, formKey) {
    final TextStyle labelColor =
        Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white);
    return Form(
      key: formKey,
      child: Column(
        spacing: 30,
        children: [
          CustomTextFormField(
            controller: nameController,
            labelText: 'Name',
            labelColor: labelColor,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Name is required';
              }
              if (value.length < 5) {
                return 'Name must be at least 5 characters long';
              }
              return null;
            },
          ),
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
          CustomTextFormField(
            controller: confirmPasswordController,
            labelText: 'Confirm Password',
            labelColor: labelColor,
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
          ),
          _signUpHeaderWithActionButton(context, nameController,
              emailController, passwordController, formKey),
          SizedBox(height: 20),
          _signInLinkUI(context),
          SizedBox(
            height: height * 0.1,
          )
        ],
      ),
    );
  }

  Widget _signUpHeaderWithActionButton(BuildContext context, nameController,
      emailController, passwordController, formKey) {
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

  Widget _signInLinkUI(BuildContext context) {
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
