import 'dart:async'; // Add this import
import 'package:flutter/material.dart';
import 'package:water_sort_puzzle/screens/LevelsScreen.dart'; // Correct import

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _simulateLoading();
  }

  void _simulateLoading() {
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        _progress += 0.1;
        if (_progress >= 1.0) {
          timer.cancel();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LevelsScreen()),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Water Sort Puzzle',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Image.asset(
              'assets/splash_icon.jpg', // Add your splash image here
              width: 150,
            ),
            SizedBox(height: 40),
            CircularProgressIndicator(
              value: _progress,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              backgroundColor: Colors.lightBlueAccent,
            ),
            SizedBox(height: 10),
            Text(
              '${(_progress * 100).toInt()}%',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
