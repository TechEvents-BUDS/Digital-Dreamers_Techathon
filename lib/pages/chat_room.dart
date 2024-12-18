// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ChatRoom extends StatefulWidget {
  final group;
  const ChatRoom({Key? key, this.group}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final controller = TextEditingController();
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          'CHAT ROOM',
          style: GoogleFonts.bebasNeue(
            fontSize: 30,
          ),
        ),
        elevation: 0,
        centerTitle: false,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(15),
              topRight: const Radius.circular(15),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              StreamBuilder(
                  stream: firestore
                      .collection('Chat Rooms')
                      .doc(widget.group)
                      .collection('messages')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    return snapshot.hasData
                        ? Expanded(
                            child: ListView.builder(
                                reverse: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, i) {
                                  return Row(
                                    children: [
                                      if (snapshot.data!.docs.reversed
                                              .toList()[i]['sender'] ==
                                          auth.currentUser!.displayName)
                                        const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              color: Colors.deepPurple,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  snapshot.data!.docs.reversed
                                                                  .toList()[i]
                                                              ['sender'] !=
                                                          auth.currentUser!
                                                              .displayName
                                                      ? CrossAxisAlignment.start
                                                      : CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                    snapshot.data!.docs.reversed
                                                        .toList()[i]['sender'],
                                                    style: const TextStyle(
                                                        color: Colors.white70,
                                                        fontSize: 8)),
                                                Text(
                                                  snapshot.data!.docs.reversed
                                                      .toList()[i]['msg'],
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (snapshot.data!.docs.reversed
                                              .toList()[i]['sender'] !=
                                          auth.currentUser!.displayName)
                                        const Spacer()
                                    ],
                                  );
                                }),
                          )
                        : Container();
                  }),
              SizedBox(
                height: 60,
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(11)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: TextField(
                              controller: controller,
                              decoration: const InputDecoration(
                                hintText: 'Write Message',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            firestore
                                .collection('Chat Rooms')
                                .doc(widget.group)
                                .collection('messages')
                                .doc(DateTime.now().toString())
                                .set({
                              'sender': auth.currentUser!.displayName,
                              'msg': controller.text,
                              'time': DateFormat('hh:mm').format(DateTime.now())
                            });
                            controller.clear();
                            setState(() {});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(11)),
                            child: const Center(
                              child: Icon(
                                Icons.send_rounded,
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
