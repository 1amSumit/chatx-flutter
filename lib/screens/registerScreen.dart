import 'package:chatx/screens/login.dart';
import 'package:chatx/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'roundedBtn.dart';

class LoginRegisterScreen extends StatefulWidget {
  const LoginRegisterScreen({super.key});
  static const String id = "register_screen";

  @override
  State<LoginRegisterScreen> createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);

    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
              ),
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    width: 140.0,
                    height: 140.0,
                    child: Image.asset(
                      'images/logo-chatx.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Chat_X',
                    textStyle: const TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: const Duration(milliseconds: 350),
                  ),
                ],
                totalRepeatCount: 6,
                pause: const Duration(milliseconds: 1000),
                displayFullTextOnTap: true,
                stopPauseOnTap: false,
              )
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          RoundedButton(
            text: "Log In",
            screenId: LogIn.id,
            color: Colors.orange[300],
          ),
          RoundedButton(
            text: "Sign Up",
            screenId: SignUp.id,
            color: Colors.orange,
          )
        ],
      ),
    );
  }
}
