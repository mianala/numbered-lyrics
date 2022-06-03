

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase (
    join(await getDatabasesPath(), 'fiderana_db.db'),
    onCreate: (db,version){
      return db.execute('CREATE TABLE songs(id INTEGER PRIMARY KEY, title TEXT, content TEXT, key TEXT, verses NUMBER, number NUMBER)')
    }
  )
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
