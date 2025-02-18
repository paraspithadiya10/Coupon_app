import 'package:demo_app/widgets/social_buttons_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    TextEditingController controller = TextEditingController();

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
            screenNameSocialButtonsAndFormUI(width, height, context, controller)
          ],
        ),
      ),
    );
  }

  Widget screenNameSocialButtonsAndFormUI(
      double width, double height, BuildContext context, controller) {
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
                child: formTextFieldsUI(context, controller, height)),
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

  Widget formTextFieldsUI(context, controller, height) {
    return Form(
      child: Column(
        spacing: 30,
        children: [
          TextFormField(
            decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.white)),
            controller: controller,
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.white)),
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.white),
            ),
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
                labelText: 'Confirm Password',
                labelStyle: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.white)),
          ),
          textAndButtonUI(context),
          SizedBox(height: 20),
          signInButtonUI(context),
          SizedBox(
            height: height * 0.1,
          )
        ],
      ),
    );
  }

  Widget textAndButtonUI(BuildContext context) {
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
                Navigator.pop(context);
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
