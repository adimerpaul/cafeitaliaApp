import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int cartItems = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Icon(
          Icons.menu,
          color: Colors.grey[900],
          size: 36,
        ),
        actions: [
          badges.Badge(
            position: badges.BadgePosition.topEnd(top: -10, end: 5),
            badgeContent: Text(
              cartItems.toString(),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            child: Icon(
              Icons.shopping_cart,
              color: Colors.grey[900],
              size: 36,
            ),
          ),
        ],
      ),
    );
  }
}