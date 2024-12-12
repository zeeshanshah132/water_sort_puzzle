import 'package:flutter/material.dart';
import 'package:water_sort_puzzle/screens/GameScreen.dart';

class LevelsScreen extends StatefulWidget {
  @override
  _LevelsScreenState createState() => _LevelsScreenState();
}

class _LevelsScreenState extends State<LevelsScreen> {
  int completedLevel = 1; // Track the highest completed level (can be stored in SharedPreferences)

  // List of levels, can be expanded as needed
  List<String> levels = ["Level 1", "Level 2", "Level 3", "Level 4", "Level 5", "Level 6"];

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
            // Loop through the levels and show buttons for unlocked levels
            ...List.generate(levels.length, (index) {
              return _buildLevelButton(context, index + 1);
            }),
          ],
        ),
      ),
    );
  }

  // Helper function to create level buttons
  Widget _buildLevelButton(BuildContext context, int level) {
    bool isLocked = level > completedLevel;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton(
        onPressed: isLocked
            ? null // Disable the button if the level is locked
            : () {
          // Navigate to the game screen with the selected level
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GameScreen(level: level),
            ),
          ).then((_) {
            // After completing the level, unlock the next level
            if (level == completedLevel) {
              setState(() {
                completedLevel = level + 1; // Unlock the next level
              });
            }
          });
        },
        child: Text(
          levels[level - 1],
          style: TextStyle(fontSize: 18),
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          backgroundColor: isLocked ? Colors.grey : Colors.blueAccent, // Locked levels are grey
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

