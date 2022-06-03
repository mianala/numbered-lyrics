
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase (
    join(await getDatabasesPath(), 'fiderana_db.db'),
    onCreate: (db,version){
      // todo: isn't needed anymore because songs already present
      return db.execute('CREATE TABLE songs(id INTEGER PRIMARY KEY, title TEXT, content TEXT, key TEXT, verses NUMBER, number NUMBER)')
    }
  )
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const all_songs = songs();
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}

class Song {
  final int id;
  final String number;
  final String content;
  final String title;
  final String key;
  final Int verses;

  const Dog({
    required this.id,
    required this.title,
    required this.content,
  });
}

Future<List<Song>> songs() async {
  final db = await database;

  final List<Map<String, dynamic>> maps = await db.query('songs');

  return List.generate(maps.length, (i) {
    return Song(
      id: maps[i]['id'],
      title: maps[i]['title'],
      content: maps[i]['content'],
      key: maps[i]['key'], 
      verses: maps[i]['verses'],
      number: maps [i]['number'],
    );
  });
}

Song findSong(int id) => list.firstWhere((song) => song.id == id);
