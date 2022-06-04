import 'dart:async';
import 'dart:io';
import 'song.dart';
import 'database_helper.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hira Fiderana',
      home: const HomeScreen(),
      routes: {
        "/grid": (context) => const SongGridViewScreen(),
        "/song": (context) => const SongPage(
              song: Song(
                id: 1,
                number: 1,
                title: "Hira Fiderana",
                content: "",
                verses: 0,
                key: "",
              ),
            ),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hira Fiderana'),
      ),
      body: FutureBuilder(
          future: DatabaseHelper().songs(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                          "${snapshot.data[index].number} ${snapshot.data[index].title})"),
                      subtitle: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                              "🎹 ${snapshot.data[index].key} 📃 ${snapshot.data[index].verses}"),
                        ],
                      ),
                      onTap: () {
                        // Navigator.pushNamed(context, "/song",
                        //     arguments: {snapshot.data[index]});

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SongPage(
                              song: snapshot.data[index],
                            ),
                          ),
                        );
                      },
                    );
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
      // bottomAppBar with icons
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.apps),
              onPressed: () {
                //  navigate to named route
                Navigator.pushNamed(context, '/grid');
              },
            ),
            IconButton(
              icon: const Icon(Icons.list),
              onPressed: () {
                // navigate to home
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
            IconButton(
              icon: const Icon(Icons.article),
              onPressed: () {
                Navigator.pushNamed(context, '/song');
              },
            ),
          ],
        ),
      ),
    );
  }
}

// SongGridViewScreen
class SongGridViewScreen extends StatelessWidget {
  const SongGridViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Bar'),
      ),
      body: FutureBuilder(
          future: DatabaseHelper().songs(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                  itemCount: snapshot.data.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5),
                  itemBuilder: (BuildContext context, int index) {
                    return Text("${snapshot.data[index].number}");
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

class SongPage extends StatelessWidget {
  const SongPage({super.key, required this.song});

  final Song song;

  @override
  Widget build(BuildContext context) {
    // display song title and content

    return Scaffold(
      appBar: AppBar(
        title: Text(song.title),
      ),
      body: Text(song.content),
    );
  }
}
