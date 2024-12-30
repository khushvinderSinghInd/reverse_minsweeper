import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:minesweeper_game/firebase_options.dart';
import 'package:minesweeper_game/src/modules/auth/screens/splash_screen.dart';

import 'package:minesweeper_game/src/services/app_theme.dart';
import 'package:minesweeper_game/src/services/local_db.dart';
import 'package:minesweeper_game/src/services/shared_prefs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {});
  await SqlDBService.sqlDBServiceinstance.database;
  final bool isDark = await SharedPrefs.getBool(key: "isDarkTheme") ?? false;
  final bool isLoggedIn = await SharedPrefs.getBool(key: "isLoggedIn") ?? false;
  Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
  runApp(
    MainApp(isLoggedIn: isLoggedIn),
  );
}

class MainApp extends StatelessWidget {
  final bool isLoggedIn;
  const MainApp({required this.isLoggedIn, super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(isLoggedIn: isLoggedIn),
          theme: AppTheme.baseTheme,
          darkTheme: AppTheme.darkTheme,
        );
      },
    );
  }
}


// import 'dart:async';
// import 'dart:math';

// import 'package:flutter/material.dart';

// void main() {
//   runApp(ReverseMinesweeperApp());
// }

// class ReverseMinesweeperApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ReverseMinesweeperGame(),
//     );
//   }
// }

// class ReverseMinesweeperGame extends StatefulWidget {
//   @override
//   _ReverseMinesweeperGameState createState() => _ReverseMinesweeperGameState();
// }

// class _ReverseMinesweeperGameState extends State<ReverseMinesweeperGame> {
//   int gridSize = 10;
//   static int totalBombs = 15;
//   late List<List<bool>> bombGrid;
//   late List<List<bool>> pieceGrid;
//   int discoveredBombs = 0;
//   int remainingBombs = totalBombs;
//   Timer? bombTimer;

//   @override
//   void initState() {
//     super.initState();
//     _initializeGame();
//     _startBombTimer();
//   }

//   void _initializeGame() {
//     bombGrid =
//         List.generate(gridSize, (_) => List.generate(gridSize, (_) => false));
//     pieceGrid =
//         List.generate(gridSize, (_) => List.generate(gridSize, (_) => false));

//     Random random = Random();
//     int bombsPlaced = 0;
//     while (bombsPlaced < totalBombs) {
//       int row = random.nextInt(gridSize);
//       int col = random.nextInt(gridSize);
//       if (!bombGrid[row][col]) {
//         bombGrid[row][col] = true;
//         bombsPlaced++;
//       }
//     }
//   }

//   void _startBombTimer() {
//     bombTimer = Timer.periodic(Duration(seconds: 10), (timer) {
//       _explodeRandomBomb();
//     });
//   }

//   void _explodeRandomBomb() {
//     List<List<int>> bombLocations = [];
//     for (int row = 0; row < gridSize; row++) {
//       for (int col = 0; col < gridSize; col++) {
//         if (bombGrid[row][col]) {
//           bombLocations.add([row, col]);
//         }
//       }
//     }

//     if (bombLocations.isNotEmpty) {
//       Random random = Random();
//       List<int> location = bombLocations[random.nextInt(bombLocations.length)];
//       setState(() {
//         bombGrid[location[0]][location[1]] = false;
//         remainingBombs--;
//       });

//       if (remainingBombs == 0) {
//         _endGame();
//       }
//     }
//   }

//   Widget _buildDraggablePiece() {
//     return Draggable<int>(
//       data: 1,
//       feedback: Container(
//         width: 50,
//         height: 50,
//         color: Colors.blue.withOpacity(0.7),
//       ),
//       child: Container(
//         width: 50,
//         height: 50,
//         color: Colors.blue,
//       ),
//       childWhenDragging: Container(
//         width: 50,
//         height: 50,
//         color: Colors.grey,
//       ),
//     );
//   }

//   void _handleDrop(int row, int col) {
//     setState(() {
//       if (bombGrid[row][col]) {
//         bombGrid[row][col] = false;
//         discoveredBombs++;
//         remainingBombs--;
//       }
//       pieceGrid[row][col] = true;

//       if (remainingBombs == 0) {
//         _endGame();
//       }
//     });
//   }

//   void _endGame() {
//     bombTimer?.cancel();
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Game Over'),
//         content: Text('You discovered $discoveredBombs bombs!'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               _restartGame();
//             },
//             child: Text('Restart'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _restartGame() {
//     setState(() {
//       discoveredBombs = 0;
//       remainingBombs = totalBombs;
//       _initializeGame();
//       _startBombTimer();
//     });
//   }

//   void _showBoardSizeDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         int tempGridSize = gridSize;
//         return AlertDialog(
//           title: Text('Customize Board Size'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text('Select Grid Size (e.g., 8x8, 12x12):'),
//               Slider(
//                 value: tempGridSize.toDouble(),
//                 min: 5,
//                 max: 15,
//                 divisions: 10,
//                 label: '${tempGridSize}x$tempGridSize',
//                 onChanged: (value) {
//                   setState(() {
//                     tempGridSize = value.toInt();
//                   });
//                 },
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 setState(() {
//                   gridSize = tempGridSize;
//                   totalBombs = (gridSize * gridSize / 6).toInt(); // Adjust bombs based on grid size
//                   _restartGame();
//                 });
//                 Navigator.of(context).pop();
//               },
//               child: Text('Apply'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Reverse Minesweeper'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.settings),
//             onPressed: _showBoardSizeDialog,
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Text('Discovered Bombs: $discoveredBombs'),
//           Text('Remaining Bombs: $remainingBombs'),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: List.generate(5, (index) => _buildDraggablePiece()),
//           ),
//           Expanded(
//             child: GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: gridSize,
//               ),
//               itemCount: gridSize * gridSize,
//               itemBuilder: (context, index) {
//                 int row = index ~/ gridSize;
//                 int col = index % gridSize;
//                 return DragTarget<int>(
//                   builder: (context, candidateData, rejectedData) {
//                     return Container(
//                       margin: EdgeInsets.all(2),
//                       color: pieceGrid[row][col]
//                           ? Colors.blue
//                           : bombGrid[row][col]
//                               ? Colors.red
//                               : Colors.grey,
//                       width: 50,
//                       height: 50,
//                     );
//                   },
//                   onWillAccept: (data) {
//                     return !pieceGrid[row][col];
//                   },
//                   onAccept: (data) {
//                     _handleDrop(row, col);
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     bombTimer?.cancel();
//     super.dispose();
//   }
// }
