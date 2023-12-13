import 'package:flutter/material.dart';

class MyTab extends StatelessWidget {
  const MyTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        'Café',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      )
    );
  }
}
