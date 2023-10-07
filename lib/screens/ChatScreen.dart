// import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  static const String id = "chat_screen";
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final fieldText = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  String messageText = "";

  void clearText() {
    fieldText.clear();
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  void messagesStream() async {
    await for (var snapshot in _firestore.collection("messages").snapshots()) {
      for (var messages in snapshot.docs) {
        print(messages.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1D836),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                color: Color(0xFFF1D836),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(FontAwesomeIcons.arrowLeft),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      "Chat",
                      style: TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Source Sans 3',
                      ),
                    ),
                    TextButton(
                      child: Text(
                        "Log out",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'Source Sans 3',
                            color: Colors.black),
                      ),
                      onPressed: () {
                        messagesStream();
                        // _auth.signOut();
                        // Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFE4DBBE),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0)),
                ),
                child: Column(
                  children: [
                    Expanded(
                      flex: 7,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: _firestore.collection("messages").snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final messages = snapshot.data.docs;
                            List<Widget> messageWidgets = [];

                            for (var message in messages) {
                              final messageText = message["text"];
                              final messageSender = message["senderField"];
                              messageWidgets.add(
                                ListTile(
                                  title: Text(messageSender),
                                  subtitle: Text(messageText),
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: TextField(
                          controller: fieldText,
                          onChanged: (value) {
                            messageText = value;
                          },
                          decoration: InputDecoration(
                            suffixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              child: IconButton(
                                onPressed: () {
                                  clearText();
                                  _firestore.collection('messages').add({
                                    "text": messageText,
                                    "senderField": loggedInUser.email
                                  });
                                },
                                icon: Icon(FontAwesomeIcons.paperPlane),
                                color: Colors.yellow[600],
                              ),
                            ),
                            filled: true,
                            fillColor: Color(0xFFB2AE94),
                            hintText: "Enter your Email",
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Source Sans 3',
                              fontWeight: FontWeight.bold,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(32.0),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFB2AE94), width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFB2AE94), width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// colors : #C6AD13
// colors : #C6BFA2
// colors : #B2AE94
