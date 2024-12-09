import 'package:flutter/material.dart';
import 'package:water_sort_puzzle/screens/GameScreen.dart';
class LevelsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Levels'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select a level:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildLevelButton(context, 1),
            _buildLevelButton(context, 2),
            _buildLevelButton(context, 3),
            _buildLevelButton(context, 4),
            _buildLevelButton(context, 5),
            // Add more levels as needed
          ],
        ),
      ),
    );
  }

  // Helper function to create level buttons
  Widget _buildLevelButton(BuildContext context, int level) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton(
        onPressed: () {
          // Navigate to the game screen with the selected level
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GameScreen(level: level),
            ),
          );
        },
        child: Text(
          'Level $level',
          style: TextStyle(fontSize: 18),
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
