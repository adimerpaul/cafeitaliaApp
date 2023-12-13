import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:line_icons/line_icons.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int cartItems = 5;
  List<Widget> tabs = [
    Tab(
      child: Icon(LineIcons.breadSlice, size: 36)
    ),
    Tab(
        child: Icon(LineIcons.coffee, size: 36)
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Icon(
              Icons.menu,
              color: Colors.grey[900],
              size: 36,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: badges.Badge(
                position: badges.BadgePosition.topEnd(top: -10, end: -12),
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
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Row(
                children: [
                  Text(
                    'Seleccionar una ',
                    style: TextStyle(
                      fontSize: 20,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'CATEGORIA',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            TabBar(
              tabs: tabs,
              labelColor: Colors.purple,
              unselectedLabelColor: Colors.grey[400],
              indicatorColor: Colors.purple,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 4,
              labelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}