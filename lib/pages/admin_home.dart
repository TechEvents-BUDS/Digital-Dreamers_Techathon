import 'package:bidobid/pages/admin_product.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'admin_users.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'ADMIN PANEL',
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
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 150,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.only(
                    right: 10, left: 10, top: 15, bottom: 0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const AdminProduct();
                        },
                      ),
                    );
                  },
                  child: const Card(
                      child: Center(
                    child: Text("Go to Product"),
                  )),
                ),
              ),
              Container(
                width: double.infinity,
                height: 150,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const AdminUsers();
                        },
                      ),
                    );
                  },
                  child: const Card(
                      child: Center(
                    child: Text("Go to Users"),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
