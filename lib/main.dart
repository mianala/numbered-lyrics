import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

class DatabaseHelper {
  static Database? _database;
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._createInstance();
    return _databaseHelper!;
  }

  Future<Database?> get database async {
    _database ??= await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "hira_fiderana.db");

// Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "hira_fiderana.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }
// open the database
    return await openDatabase(path, readOnly: true);
  }

  Future<List<Song>> songs() async {
    final db = await DatabaseHelper().database;

    final List<Map<String, dynamic>> maps = await db!.query('songs');

    return List.generate(maps.length, (i) {
      return Song(
        id: int.tryParse(maps[i][0]) ?? 0,
        number: maps[i][1] as int,
        title: maps[i]['title'],
        content: maps[i]['content'],
        verses: int.tryParse(maps[i]['verses']) ?? 0,
        key: maps[i]['key'],
      );
    });
  }
}

void main() {
  runApp(const SongListScreen());
}

class SongListScreen extends StatelessWidget {
  const SongListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Song> allSongs = [];
    DatabaseHelper._createInstance()
        .songs()
        .then((songs) => {allSongs = songs});
    return MaterialApp(
      title: 'Hira Fiderana',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App Bar'),
        ),
        body: ListView.builder(
            itemCount: allSongs.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(allSongs[index].title),
                subtitle: Text(allSongs[index].key),
              );
            }),
      ),
    );
  }
}

class SongGridListScreen extends StatelessWidget {
  const SongGridListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Song> allSongs = [];

    DatabaseHelper._createInstance()
        .songs()
        .then((songs) => {allSongs = songs});
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: Center(
          child: GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
              itemCount: allSongs.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(allSongs[index].number.toString()),
                  // subtitle: Text(allSongs[index].key),
                );
              }),
        ),
      ),
    );
  }
}

class SongDetailScreen extends StatelessWidget {
  const SongDetailScreen({super.key, required this.song});

  final Song song;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(song.title),
      ),
      body: Center(
        child: Text(song.content),
      ),
    );
  }
}

class Song {
  final int id;
  final int number;
  final String content;
  final String title;
  final String key;
  final int verses;

  const Song({
    required this.id,
    required this.number,
    required this.verses,
    required this.title,
    required this.content,
    required this.key,
  });
}

Song findSong(int id, songList) => songList.firstWhere((song) => song.id == id);
