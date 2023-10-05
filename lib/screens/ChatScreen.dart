import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC6AD13),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              color: Color(0xFFC6AD13),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                  ),
                  Icon(FontAwesomeIcons.arrowLeft),
                  SizedBox(
                    width: 120.0,
                  ),
                  Text(
                    "Chat",
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Source Sans 3',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFC6BFA2),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0)),
              ),
              child: Column(
                children: [],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// colors : #C6AD13
// colors : #C6BFA2
// colors : #B2AE94
