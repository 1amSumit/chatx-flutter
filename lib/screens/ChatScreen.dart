// import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

late User loggedInUser;

final _firestore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  static const String id = "chat_screen";
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final fieldText = TextEditingController();
  final _auth = FirebaseAuth.instance;
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
      backgroundColor: Color(0xFFF8D818),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                color: Color(0xFFF8D818),
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
                  color: Color(0xFFF7EFCB),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0)),
                ),
                child: Column(
                  children: [
                    Expanded(
                        flex: 7,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0)),
                          ),
                          margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                          child: StreamBuilder<QuerySnapshot>(
                            stream:
                                _firestore.collection("messages").snapshots(),
                            builder: (context, snapshot) {
                              List<Widget> messageWidgets = [];
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.yellow,
                                  ),
                                );
                              }
                              final messages = snapshot.data!.docs.reversed;
                              print(messages);

                              for (var message in messages) {
                                final messageText = message["text"];
                                final messageSender = message["senderField"];

                                final currentUser = loggedInUser.email;

                                messageWidgets.add(
                                  MessageBubbleSender(
                                    message: messageText,
                                    sender: messageSender,
                                    isMe: currentUser == messageSender,
                                  ),
                                );
                              }
                              return ListView(
                                reverse: true,
                                children: messageWidgets,
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                              );
                            },
                          ),
                        )),
                    Expanded(
                      child: Padding(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Container(
                            color: Color(0xFFF7EFCB),
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
                                      _firestore.collection('messages').add(
                                        {
                                          "text": messageText,
                                          "senderField": loggedInUser.email
                                        },
                                      );
                                    },
                                    icon: Icon(FontAwesomeIcons.paperPlane),
                                    color: Colors.yellow[300],
                                  ),
                                ),
                                filled: true,
                                fillColor: Color(0xFFDFD9B9),
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
                                      color: Color(0xFFDFD9B9), width: 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32.0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFDFD9B9), width: 2.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32.0)),
                                ),
                              ),
                            ),
                          )),
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

// colors : #F8D818
// colors : #C6BFA2
// colors : #B2AE94

// #F8D818
// #F7EFCB
// #E9DFA0
// #F7D918
// #DFD9B9

class MessageBubbleSender extends StatelessWidget {
  const MessageBubbleSender(
      {this.message = "", this.sender = "", this.isMe = true});
  final String message;
  final String sender;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
            color: isMe ? Color(0xFFF7D916) : Color(0xFFE9DFA0),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Source Sans 3',
                ),
              ),
            ),
          ),
          Text(
            sender,
            style: TextStyle(
                fontSize: 10.0,
                fontFamily: "SOurce Sans 3",
                color: Colors.grey[800]),
          )
        ],
      ),
    );
  }
}
