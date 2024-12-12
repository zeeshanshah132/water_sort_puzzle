import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  final int level;

  GameScreen({required this.level});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<List<Color>> bottles;
  int? selectedBottleIndex;
  bool levelCompleted = false;

  @override
  void initState() {
    super.initState();
    initializeBottles(widget.level);
  }

  // Initialize bottles based on the level
  void initializeBottles(int level) {
    // Example configurations, can be made dynamic as levels increase
    if (level == 1) {
      bottles = [
        [Colors.blue, Colors.blue, Colors.red, Colors.red],
        [Colors.green, Colors.green, Colors.yellow, Colors.yellow],
        [Colors.blue, Colors.green, Colors.red, Colors.yellow],
        [Colors.yellow, Colors.red, Colors.green, Colors.blue],
        [],
        []
      ];
    } else if (level == 2) {
      bottles = [
        [Colors.blue, Colors.red, Colors.green, Colors.orange],
        [Colors.red, Colors.green, Colors.blue, Colors.orange],
        [Colors.orange, Colors.blue, Colors.red, Colors.green],
        [Colors.red, Colors.blue, Colors.orange, Colors.green],
        [],
        []
      ];
    } else {
      // Add more configurations for harder levels
      bottles = List.generate(5, (_) => []); // Empty setup for other levels
    }
  }

  // Handle bottle tap
  void onBottleTap(int index) {
    if (selectedBottleIndex == null) {
      // Select a bottle if it has colors
      if (bottles[index].isNotEmpty) {
        setState(() {
          selectedBottleIndex = index;
        });
      }
    } else {
      // Try to move the color
      if (index != selectedBottleIndex) {
        moveColor(selectedBottleIndex!, index);
      }
      setState(() {
        selectedBottleIndex = null; // Deselect after action
      });
    }
  }

  // Move the top color with animation
  void moveColor(int fromIndex, int toIndex) {
    setState(() {
      if (bottles[fromIndex].isEmpty || bottles[toIndex].length >= 4) return;

      Color colorToMove = bottles[fromIndex].last;

      // Check if the destination bottle is empty or matches the color
      if (bottles[toIndex].isEmpty || bottles[toIndex].last == colorToMove) {
        bottles[toIndex].add(bottles[fromIndex].removeLast());

        // Check for level completion
        checkLevelCompletion();
      }
    });
  }

  // Check if all bottles are solved
  void checkLevelCompletion() {
    bool isCompleted = bottles.every((bottle) =>
        bottle.isEmpty ||
        (bottle.length == 4 && bottle.every((color) => color == bottle[0])));
    if (isCompleted) {
      setState(() {
        levelCompleted = true;
      });
    }
  }

  // Build animated bottle widget with small 3D balls
  Widget buildBottle(int index) {
    bool isSelected = selectedBottleIndex == index;
    bool isCompleted = bottles[index].length == 4 &&
        bottles[index].every((color) => color == bottles[index][0]);

    return GestureDetector(
      onTap: () => onBottleTap(index),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        margin: EdgeInsets.only(bottom: isSelected ? 20 : 0),
        width: 50,
        height: 220,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
          boxShadow: isCompleted
              ? [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.8),
                    offset: Offset(4, 4),
                    blurRadius: 12,
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: List.generate(
            bottles[index].length,
            (i) => AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: 40,
              height: 40,
              margin: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: bottles[index][bottles[index].length - 1 - i],
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: Offset(2, 2),
                    blurRadius: 5,
                  ),
                ],
                gradient: RadialGradient(
                  center: Alignment(0.0, -0.4),
                  radius: 1.0,
                  colors: [
                    bottles[index][bottles[index].length - 1 - i]
                        .withOpacity(0.8),
                    bottles[index][bottles[index].length - 1 - i]
                        .withOpacity(0.3),
                  ],
                  stops: [0.0, 1.0],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Build bottles in rows with gaps
  Widget buildBottleRows() {
    List<Widget> rows = [];
    int mid = (bottles.length / 2).ceil();

    // First row
    rows.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          mid,
          (i) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            // Horizontal gap
            child: buildBottle(i),
          ),
        ),
      ),
    );

    // Second row (if there are more bottles)
    if (bottles.length > mid) {
      rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            bottles.length - mid,
            (i) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              // Horizontal gap
              child: buildBottle(i + mid),
            ),
          ),
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: rows,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Level ${widget.level}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Level ${widget.level}',
                  textStyle: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                  speed: Duration(milliseconds: 150),
                ),
              ],
              totalRepeatCount: 1, // Animation will run once
              pause: Duration(seconds: 1), displayFullTextOnTap: true,
            ),
            SizedBox(height: 20),
            buildBottleRows(),
            SizedBox(height: 20),
            if (levelCompleted)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GameScreen(level: widget.level + 1),
                    ),
                  );
                },
                child: Text('Next Level'),
              ),
          ],
        ),
      ),
    );
  }
}
