import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _MyState();
}

class _MyState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      appBar: AppBar(title: Text('WELCOME IN MY APP')),
      body: Center(
        child: Text(
          "you are welcome",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
