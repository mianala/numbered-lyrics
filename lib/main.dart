import 'song.dart';
import 'database_helper.dart';
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
      home: const SongGridViewScreen(),
      routes: {
        "/grid": (context) => const SongGridViewScreen(),
        "/list": (context) => const SongListScreen(),
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

class SongListScreen extends StatelessWidget {
  const SongListScreen({Key? key}) : super(key: key);

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
                      return GestureDetector(
                        child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black12,
                                  width: 1,
                                ),
                              ),
                            ),
                            padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 60,
                                  child: Text(
                                    "${snapshot.data[index].number}",
                                    style: const TextStyle(fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Flexible(
                                    child: Text(
                                  "${snapshot.data[index].title}",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                              ],
                            )),
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
        bottomNavigationBar: const BottomBar());
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.apps),
            onPressed: () {
              //  navigate to named route
              Navigator.pushReplacementNamed(context, '/grid');
            },
          ),
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              // navigate to home
              Navigator.pushReplacementNamed(context, '/list');
            },
          ),
          IconButton(
            icon: const Icon(Icons.article),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/song');
            },
          ),
        ],
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
          title: const Text('Laharan\'kira'),
        ),
        body: FutureBuilder(
            future: DatabaseHelper().songs(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                    itemCount: snapshot.data.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5),
                    itemBuilder: (BuildContext context, int index) {
                      return SquaredButton(
                        character: snapshot.data[index].number.toString(),
                        size: 20.0,
                        borderWidth: 1.0,
                        onPressed: () {
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
        bottomNavigationBar: const BottomBar());
  }
}

class SongPage extends StatelessWidget {
  const SongPage({super.key, required this.song});

  final Song song;

  @override
  Widget build(BuildContext context) {
    // display song title and content

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(65),
          child: AppBar(
            title: Column(
              children: [
                Text(song.title, style: const TextStyle(fontSize: 20)),
                // style subtitle
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Tonalité ${song.key}",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Text("Fiverenana: ${song.verses.toString()}",
                        style: const TextStyle(fontSize: 14)),
                  ],
                )
              ],
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Expanded(
            child: SingleChildScrollView(
                child: Padding(
                    child: Text(song.content, style: TextStyle(fontSize: 22.0)),
                    padding: const EdgeInsets.all(18.0)))),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}

class SquaredButton extends StatefulWidget {
  final double size;
  final double borderWidth;
  final String character;
  final void Function()? onPressed;

  const SquaredButton({
    Key? key,
    this.size = 28.0,
    this.borderWidth = 1.0,
    required this.character,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<SquaredButton> createState() => _SquaredButtonState();
}

class _SquaredButtonState extends State<SquaredButton> {
  @override
  Widget build(BuildContext context) {
    final String character = widget.character;
    final double size = widget.size;
    final double borderWidth = widget.borderWidth;
    final void Function()? onPressed = widget.onPressed;

    return Material(
      shape: const BeveledRectangleBorder(),
      child: Ink(
        child: SizedBox(
          width: size,
          height: size,
          child: Container(
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              border: Border.all(width: borderWidth, color: Colors.black12),
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.black38,
              ),
              onPressed: onPressed,
              child: FittedBox(
                child: Text(
                  character,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: size,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
