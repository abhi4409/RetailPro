import 'dart:async';
import 'package:flutter/material.dart';
import '../home/Home.dart';
import 'Loginpage.dart';

class Spla extends StatefulWidget {
  const Spla({super.key});

  @override
  State<Spla> createState() => _SplaState();
}

class _SplaState extends State<Spla> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(
      const Duration(seconds: 2),
          () {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Log(),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>Hom(),
              ),
            );
          },
          child: Container(
            height: 300,
            width: 300,
            decoration:BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/images/logo.png"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}