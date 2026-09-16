import 'package:app2/dashboard.dart';
import 'package:app2/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Chack extends StatefulWidget {
  const Chack({super.key});

  @override
  State<Chack> createState() => _ChackState();
}

class _ChackState extends State<Chack> {
  @override
  void initState() {
    super.initState();
    check();
  }

  Future<void> check() async {
    final prefs = await SharedPreferences.getInstance();
    bool islogged = prefs.getBool("isLogged") ?? false;
    String? name = prefs.getString("firstname");
    if (islogged && name != null && name.isNotEmpty) {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => App()),
      );
    } else {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
