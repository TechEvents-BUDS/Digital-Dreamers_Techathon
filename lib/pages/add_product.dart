// ignore_for_file: file_names, use_build_context_synchronously, non_constant_identifier_names

import 'dart:convert';

import 'package:bidobid/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../widget/widget.dart';

class CallApi {
  String baseUrl = "http://10.0.2.2:8000/api/add-product";
  Future<String> postData(Map<String, dynamic> data) async {
    try {
      var response = await http.post(
        Uri.parse(baseUrl),
        body: jsonEncode(data),
        headers: {"Content-Type": "application/json; charset=UTF-8"},
      );
      if (response.statusCode == 200) {
        return "success";
      } else {
        return "err";
      }
    } catch (SocketException) {
      return "err";
    }
  }
}

class UserAddProduct extends StatefulWidget {
  const UserAddProduct({super.key});

  @override
  State<UserAddProduct> createState() => _UserAddProductState();
}

class _UserAddProductState extends State<UserAddProduct> {
  final _ownerController = FirebaseAuth.instance.currentUser!.email;
  final _productNameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _priceController = TextEditingController();
  final _endDateController = TextEditingController();
  final _productInformationController = TextEditingController();
  final _deliveryInformationController = TextEditingController();
  bool textFieldEmpty = false;

  Future launch() async {
    // try {
    await FirebaseFirestore.instance.collection('products').add({
      'ownerEmail': _ownerController,
      'name': _productNameController.text.trim(),
      'category': _categoryController.text.trim(),
      'imageUrl': _imageUrlController.text.trim(),
      'price': double.parse(_priceController.text.trim()),
      'endDate': DateTime.parse(_endDateController.text.trim()),
      'productInformation': _productInformationController.text.trim(),
      'deliveryInformation': _deliveryInformationController.text.trim(),
      'isPopular': true,
      'isRecommended': true,
    });
    _productNameController.clear();
    _categoryController.clear();
    _imageUrlController.clear();
    _priceController.clear();
    _endDateController.clear();
    _productInformationController.clear();
    _deliveryInformationController.clear();
    const snackBar = SnackBar(content: Text('Product Launched Successfully!'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    flutterLocalNotificationsPlugin.show(
      0,
      "Go Check it Out",
      "A new product is up for bidding!",
      NotificationDetails(
        android: AndroidNotificationDetails(channel.id, channel.name,
            importance: Importance.high,
            color: Colors.blue,
            playSound: true,
            icon: '@mipmap/ic_launcher'),
      ),
    );
    // } catch (err) {
    //   const snackBar = SnackBar(content: Text('404 | Error'));
    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // }
  }

  // Future launch() async {
  //   String res = await CallApi().postData(data);
  //   if (res == "success") {
  //     const snackBar =
  //         SnackBar(content: Text('Product Launched Successfully!'));
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //     flutterLocalNotificationsPlugin.show(
  //       0,
  //       "Go Check it Out",
  //       "A new product is up for bidding!",
  //       NotificationDetails(
  //         android: AndroidNotificationDetails(channel.id, channel.name,
  //             importance: Importance.high,
  //             color: Colors.blue,
  //             playSound: true,
  //             icon: '@mipmap/ic_launcher'),
  //       ),
  //     );
  //   } else {
  //     const snackBar = SnackBar(content: Text('404 | Error'));
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   }
  // }

  @override
  void dispose() {
    _productNameController.dispose();
    _categoryController.dispose();
    _imageUrlController.dispose();
    _priceController.dispose();
    _endDateController.dispose();
    _productInformationController.dispose();
    _deliveryInformationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(channel.id, channel.name,
                  color: Colors.blue,
                  playSound: true,
                  icon: '@mipmap/ic_launcher'),
            ),
          );
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text('${notification.title}'),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${notification.body}'),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          'ADD PRODUCT',
          style: GoogleFonts.bebasNeue(
            fontSize: 30,
          ),
        ),
        elevation: 0,
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
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const SectionTitle(title: 'FILL TO LAUNCH'),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    controller: _productNameController,
                    enableSuggestions: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Product Name',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    controller: _categoryController,
                    enableSuggestions: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Select Product Category',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    controller: _imageUrlController,
                    enableSuggestions: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Image URL',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    controller: _priceController,
                    enableSuggestions: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.currency_rupee_outlined,
                        color: Colors.grey[200],
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Starting Bid',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    controller: _endDateController,
                    enableSuggestions: true,
                    readOnly: true,
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.grey[200],
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'End of Session',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));

                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate!);
                      setState(() {
                        _endDateController.text =
                            formattedDate; //set output date to TextField value.
                      });
                                        },
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    minLines: 1,
                    maxLines: 10,
                    keyboardType: TextInputType.multiline,
                    controller: _productInformationController,
                    enableSuggestions: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Product Details',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    minLines: 1,
                    maxLines: 10,
                    keyboardType: TextInputType.multiline,
                    controller: _deliveryInformationController,
                    enableSuggestions: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Delivery Details',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: launch,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Center(
                        child: Text(
                          'Launch Product',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
