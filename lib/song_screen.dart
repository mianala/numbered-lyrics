import 'song.dart';
import 'package:flutter/material.dart';
import 'shared_preferences.dart';
import 'bottom_bar.dart';

class SongScreen extends StatelessWidget {
  const SongScreen({super.key, required this.song});

  final Song song;

  @override
  Widget build(BuildContext context) {
    if (song.id != 0) {
      setLatestSong(song);
      return NormalSongView(song: song);
    } else {
      return FutureBuilder(
          future: getLatestSong(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const SongNotSelectedScaffold();
            }

            if (snapshot.hasData) {
              var latestSong = snapshot.data;
              // song from shared preferences
              return latestSongScaffold(latestSong, context);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          });
    }
  }

  Scaffold latestSongScaffold(latestSong, BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(65),
          child: AppBar(
            title: Column(
              children: [
                Text("${latestSong.number} ${latestSong.title}",
                    style: const TextStyle(fontSize: 20)),
                // style subtitle
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Clé: ${latestSong.key}",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Text("Andininy: ${latestSong.verses.toString()}",
                        style: const TextStyle(fontSize: 14)),
                  ],
                )
              ],
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text('${latestSong.content}',
                    style: const TextStyle(fontSize: 22.0)))),
      ),
      bottomNavigationBar: bottomBar(2, context),
    );
  }
}

class NormalSongView extends StatelessWidget {
  const NormalSongView({
    Key? key,
    required this.song,
  }) : super(key: key);

  final Song song;

  @override
  Widget build(BuildContext context) {
    var keyPresent = song.key.isNotEmpty ? true : false;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(65),
          child: AppBar(
            title: Column(
              children: [
                Text("${song.number} ${song.title}",
                    style: const TextStyle(fontSize: 20)),
                // style subtitle
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                        visible: keyPresent,
                        maintainSize: false,
                        child: Text(
                          "Clé: ${song.key}     ",
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        )),
                    Text("Andininy: ${song.verses.toString()}",
                        style: const TextStyle(fontSize: 14)),
                  ],
                )
              ],
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(song.content,
                    style: const TextStyle(fontSize: 22.0)))),
      ),
      bottomNavigationBar: bottomBar(2, context),
    );
  }
}

class SongNotSelectedScaffold extends StatelessWidget {
  const SongNotSelectedScaffold({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hira")),
      body: const Center(
        child: Text("Tsy misy hira voatondro"),
      ),
      bottomNavigationBar: bottomBar(2, context),
    );
  }
}
