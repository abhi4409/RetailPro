import 'package:flutter/material.dart';
import '../inventory/Inventory.dart';
import '../sales/Sales.dart';
import 'Home.dart';

class Bottomna extends StatefulWidget {
  Bottomna({super.key});

  @override
  State<Bottomna> createState() => _BottomnaState();
}

class _BottomnaState extends State<Bottomna> {
  int selected = 0;

  final List<Widget> pages = [
    Hom(),
    Inven(),
    Sale(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selected,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.blueGrey.shade900,
          selectedItemColor: Colors.lightBlueAccent,
          unselectedItemColor: Colors.white70,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          onTap: (index) => setState(() => selected = index),
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.inventory,
              ),
              label: "Inventory",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.file_copy_sharp,
              ),
              label: "Sales",
            ),
          ],
        ),
        body: pages[selected],
      ),
    );
  }
}