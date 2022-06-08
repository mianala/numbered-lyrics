import 'dart:async';
import 'dart:io';
import 'song.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const dbFileName = 'lyrics.db';

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
    var path = join(databasesPath, dbFileName);

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
      ByteData data = await rootBundle.load(join("assets", dbFileName));
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
      var map = maps[i];
      return Song.fromMap(map);
    });
  }

  Future<List<Song>> searchSong(String search) async {
    final db = await DatabaseHelper().database;
    List<Song> songs = <Song>[];
    final List<Map<String, dynamic>> maps = await db!.query("songs",
        columns: ["id", "title", "content", "key", "verses", "number"],
        where: "title LIKE ?",
        whereArgs: ["%$search%"]);

    for (int i = 0; i < maps.length; i++) {
      var map = maps[i];
      songs.add(Song(
        id: int.tryParse(map["id"]) ?? 0,
        number: int.tryParse(map["number"]) ?? 0,
        title: map['title'],
        content: map['content'],
        verses: int.tryParse(map['verses']) ?? 0,
        key: map['key'] ?? "",
      ));
    }
    return songs;
  }
}
