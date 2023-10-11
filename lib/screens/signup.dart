import 'package:chatx/screens/ChatScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart";

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  static const String id = "sign_up";

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;
  String email = "";
  String password = "";
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Column(
        children: [
          Flexible(
            child: Hero(
              tag: "logo",
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 40.0),
                  child: SizedBox(
                    child: Image.asset('images/logo-chatx.png'),
                    width: 200.0,
                    height: 200.0,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                email = value;
              },
              decoration: InputDecoration(
                hintText: "Enter your Email",
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.yellow, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: TextField(
              textAlign: TextAlign.center,
              obscureText: true,
              onChanged: (value) {
                password = value;
              },
              decoration: InputDecoration(
                hintText: "Enter your Passowrd",
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.yellow, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 18.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Material(
              color: Colors.orange[300],
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              elevation: 5.0,
              child: MaterialButton(
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    showSpinner = false;
                  } catch (e) {
                    print(e);
                  }
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
    ));
  }
}
