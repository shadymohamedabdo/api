import 'package:flutter/material.dart';

import 'api/health.dart';
import 'api/science.dart';
import 'api/sports.dart';
class widget extends StatefulWidget {

   widget({super.key});

  @override
  State<widget> createState() => _widgetState();
}

class _widgetState extends State<widget> {
  int current = 0;

  List screen = [
    sports(),
    science(),
    health()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('News app',
        style: TextStyle(
          fontWeight: FontWeight.bold,
              color: Colors.white,
        ),),
        centerTitle: true,
      ),
      body: screen[current],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: current,
        onTap: (index){
          setState(() {
            current = index;
          });
        },
        items: [
          BottomNavigationBarItem(

              label: 'Sports',
              icon: Icon(Icons.sports)),
          BottomNavigationBarItem(
              label: 'science',
              icon: Icon(Icons.science)),
          BottomNavigationBarItem(

              label: 'health',
              icon: Icon(Icons.health_and_safety)),

        ],
      ),
    );
  }
}
