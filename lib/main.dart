import 'song.dart';
import 'package:flutter/material.dart';
import 'song_grid_view_screen.dart';
import 'song_list_screen.dart';
import 'song_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hira Fiderana',
      home: const NumbersGridScreen(),
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        "/grid": (context) => const NumbersGridScreen(),
        "/list": (context) => const SongListScreen(),
        "/song": (context) => const SongScreen(
              song: Song(),
            ),
      },
    );
  }
}
