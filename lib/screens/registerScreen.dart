import 'package:chatx/screens/login.dart';
import 'package:chatx/screens/signup.dart';
import 'package:flutter/material.dart';

class LoginRegisterScreen extends StatefulWidget {
  const LoginRegisterScreen({super.key});
  static const String id = "register_screen";

  @override
  State<LoginRegisterScreen> createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
              ),
              SizedBox(
                width: 140.0,
                height: 140.0,
                child: Image.asset(
                  'images/logo-chatx.png',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                "Chat X_",
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Material(
              color: Colors.orange[300],
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              elevation: 5.0,
              child: MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, LogIn.id);
                },
                minWidth: 300.0,
                height: 42.0,
                child: Text(
                  'Log In',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Material(
              color: Colors.orange,
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              elevation: 5.0,
              child: MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, SignUp.id);
                },
                minWidth: 300.0,
                height: 42.0,
                child: Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
