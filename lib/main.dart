import 'package:flutter/material.dart';
import 'screens/SplashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Water Sort Puzzle',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}








// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'game_state.dart';
// import 'game_logic.dart';
//
// void main() {
//   runApp(const WaterSortPuzzle());
// }
//
// class WaterSortPuzzle extends StatelessWidget {
//   const WaterSortPuzzle({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => GameState(),
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: PuzzleScreen(),
//       ),
//     );
//   }
// }
//
// class PuzzleScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final gameState = Provider.of<GameState>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Water Sort Puzzle'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: () => gameState.resetGame(),
//           ),
//         ],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             GridView.builder(
//               shrinkWrap: true,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 4,
//                 childAspectRatio: 1 / 4,
//               ),
//               itemCount: gameState.tubes.length,
//               itemBuilder: (context, index) {
//                 return TubeWidget(
//                   tube: gameState.tubes[index],
//                   index: index,
//                 );
//               },
//             ),
//             if (gameState.isGameComplete())
//               const Text(
//                 'You Win!',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class TubeWidget extends StatelessWidget {
//   final Tube tube;
//   final int index;
//
//   const TubeWidget({required this.tube, required this.index});
//
//   @override
//   Widget build(BuildContext context) {
//     final gameState = Provider.of<GameState>(context, listen: false);
//
//     return GestureDetector(
//       onTap: () {
//         // Implement tube selection logic
//         gameState.moveLiquid(index, (index + 1) % gameState.tubes.length);
//       },
//       child: Container(
//         margin: const EdgeInsets.all(4),
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.black),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: tube.colors
//               .map((color) => Expanded(
//             child: Container(color: color),
//           ))
//               .toList(),
//         ),
//       ),
//     );
//   }
// }
