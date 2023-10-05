import 'package:chatx/screens/registerScreen.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});
  static const String id = "welcome_screen";

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image(
              image: AssetImage('images/logo-chatx.png'),
            ),
          ),
          SizedBox(
            height: 60.0,
          ),
          Container(
            child: SizedBox(
              width: 250.0,
              height: 40.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, LoginRegisterScreen.id);
                },
                child: Text(
                  "Agree and continue",
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(
                    Color(0xFFFEF6E9),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
