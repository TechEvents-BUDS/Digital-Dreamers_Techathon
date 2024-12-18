// ignore_for_file: prefer_const_constructors

import 'package:bidobid/pages/login_%20page.dart';
import 'package:flutter/material.dart';

import '../pages/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // initailly show the loginPage
  bool showLoginPage = true;

  toogleScreens() {
    setState(() {
    showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(showRegisterPage: toogleScreens);
    } else {
      return RegisterPage(showLoginPage: toogleScreens);
    }
  }
}
