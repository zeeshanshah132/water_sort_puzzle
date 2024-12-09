import 'package:flutter/material.dart';


class GameScreen extends StatelessWidget {
  final int level;  // New parameter to receive level

  // Constructor to receive level
  GameScreen({required this.level});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game - Level $level'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Text(
          'Welcome to Level $level!',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
