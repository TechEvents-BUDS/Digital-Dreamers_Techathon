// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:bidobid/pages/Add_Product.dart';
import 'package:bidobid/pages/chats_page.dart';
import 'package:bidobid/pages/home_page.dart';
import 'package:flutter/material.dart';
import '../pages/cart_page.dart';
import '../pages/profile_page.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //LIST OF PAGES
  final List<Widget> _pages = [
    UserHome(),
    UserChat(),
    UserAddProduct(),
    UserCart(),
    UserProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[200],
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepPurple,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(
              Icons.home,
              size: 26,
            ),
            label: 'Home',
            backgroundColor: Colors.amber,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            activeIcon: Icon(
              Icons.message,
              size: 26,
            ),
            label: 'Chat',
            backgroundColor: Colors.amber,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            activeIcon: Icon(
              Icons.add_circle,
              size: 26,
            ),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(
              Icons.shopping_cart_rounded,
              size: 26,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            activeIcon: Icon(
              Icons.person,
              size: 26,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
