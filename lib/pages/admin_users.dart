import 'package:bidobid/controller/user_controller.dart';
import 'package:bidobid/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminUsers extends StatefulWidget {
  const AdminUsers({super.key});

  @override
  State<AdminUsers> createState() => _AdminUsersState();
}

class _AdminUsersState extends State<AdminUsers> {
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'USERS',
            style: GoogleFonts.bebasNeue(
              fontSize: 30,
            ),
          ),
          leading: GestureDetector(
            child: const Icon(
              Icons.arrow_back_ios,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: false,
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: FutureBuilder<List<UserModel>>(
              future: controller.getAllUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (c, index) {
                        return Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: ListTile(
                                  iconColor: Colors.blue,
                                  tileColor: Colors.blue.withOpacity(0.1),
                                  leading: const Icon(Icons.person),
                                  title: Text(snapshot.data![index].name),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(snapshot.data![index].email),
                                      // Text(snapshot.data![index].number),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10)
                          ],
                        );
                      },
                    );
                  }
                }
                return Container();
              },
            ),
          ),
        ));
  }
}
