import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Title'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_alert),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.navigate_next),
            onPressed: () {},
          ),
        ],
      ),
      body: const Center(
        child: Text('Hello, World!'),
      ),
    );
  }
}
