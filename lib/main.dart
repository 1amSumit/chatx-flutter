import 'package:chatx/firebase_options.dart';
import 'package:chatx/screens/ChatScreen.dart';
import 'package:chatx/screens/login.dart';
import 'package:chatx/screens/registerScreen.dart';
import 'package:chatx/screens/signup.dart';
import 'package:chatx/screens/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Welcome.id,
      routes: {
        Welcome.id: (context) => Welcome(),
        LoginRegisterScreen.id: (context) => LoginRegisterScreen(),
        LogIn.id: (constants) => LogIn(),
        SignUp.id: (context) => SignUp(),
        ChatScreen.id: (context) => ChatScreen()
      },
    );
  }
}
