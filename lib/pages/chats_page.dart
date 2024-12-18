// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_typing_uninitialized_variables, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../logics/auth.dart';
import 'chat_room.dart';

class UserChat extends StatefulWidget {
  const UserChat({Key? key}) : super(key: key);

  @override
  State<UserChat> createState() => _UserChatState();
}

class _UserChatState extends State<UserChat> {
  var data;
  var msgname;
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  bool errorMessage = false;

  @override
  void initState() {
    Auth().getInfo().then((value) {
      data = value;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  var search = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          'CHATS',
          style: GoogleFonts.bebasNeue(
            fontSize: 30,
          ),
        ),
        elevation: 0,
        centerTitle: false,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 50, 2, 100),
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Create Group'),
                  content: Container(
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: errorMessage,
                          child: Text(
                            'Enter the Field',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                        TextField(
                          decoration: const InputDecoration(
                            hintText: 'Enter Name',
                          ),
                          onChanged: (a) {
                            setState(() {
                              msgname = a;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    OutlinedButton(
                        onPressed: () {
                          if (msgname != null) {
                            firestore
                                .collection('Chat Rooms')
                                .doc(msgname)
                                .collection('messages')
                                .doc(DateTime.now().toString())
                                .set({
                              'sender': auth.currentUser!.email,
                              'msg': 'Hi! , New Chat Room Created',
                              'time': DateFormat('hh:mm').format(DateTime.now())
                            });
                            firestore
                                .collection('Chat Rooms')
                                .doc(msgname)
                                .set({'status': 'active'});
                            Navigator.pop(context);
                          } else {
                            errorMessage = true;
                          }
                        },
                        child: const Text('Create'))
                  ],
                );
              });
        },
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Column(
            children: [
              TextField(
                onChanged: (l) {
                  setState(() {
                    search = l;
                  });
                },
                decoration: const InputDecoration(
                    hintText: 'Search',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search)),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: StreamBuilder(
                    stream: firestore.collection('Chat Rooms').snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      return !snapshot.hasData
                          ? Container()
                          : ListView.builder(
                              itemCount: snapshot.data!.docs.where((element) {
                                return element.id.contains(search);
                              }).length,
                              itemBuilder: (context, i) {
                                return GroupCard(
                                  title: snapshot.data!.docs
                                      .where((element) {
                                        return element.id.contains(search);
                                      })
                                      .toList()[i]
                                      .id,
                                  snap: snapshot.data!.docs
                                      .where((element) {
                                        return element.id.contains(search);
                                      })
                                      .toList()[i]
                                      .reference
                                      .collection('messages')
                                      .snapshots(),
                                );
                              },
                            );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GroupCard extends StatelessWidget {
  final title;
  final snap;
  const GroupCard({Key? key, this.title, this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ChatRoom(
              group: title,
            );
          }));
        },
        child: Container(
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
              color: Colors.grey[400], borderRadius: BorderRadius.circular(11)),
          child: Row(
            children: [
              const SizedBox(
                width: 12,
              ),
              const CircleAvatar(
                radius: 24,
                backgroundColor: Colors.deepPurple,
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                  StreamBuilder(
                      stream: snap,
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        return !snapshot.hasData
                            ? Container()
                            : Text(
                                snapshot.data!.docs.last['msg'],
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 45, 43, 43),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400),
                              );
                      }),
                ],
              ),
              const Spacer(),
              StreamBuilder(
                  stream: snap,
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    return snapshot.hasData
                        ? Text(
                            snapshot.data!.docs.last['time'].toString(),
                            style: const TextStyle(
                                color: Color.fromRGBO(18, 38, 67, 1),
                                fontSize: 11,
                                fontWeight: FontWeight.w400),
                          )
                        : Container();
                  }),
              const SizedBox(
                width: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
