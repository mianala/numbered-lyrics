import 'song.dart';
import 'database_helper.dart';
import 'package:flutter/material.dart';
import 'shared_preferences.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        "/grid": (context) => const SongGridViewScreen(),
        "/list": (context) => const SongListScreen(),
        "/song": (context) => const SongPage(
              song: Song(
                id: 0,
                number: 0,
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
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: SongSearchDelegate());
              },
            )
          ],
          automaticallyImplyLeading: false,
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
        bottomNavigationBar: bottomBar(1, context));
  }
}

class SongSearchDelegate extends SearchDelegate<Song> {
  @override
  String get searchFieldLabel => "Hitady hira";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(
            context,
            const Song(
                id: 0, number: 0, title: "", content: "", verses: 0, key: ''));
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // display search results
    return FutureBuilder(
        future: DatabaseHelper().searchSong(query),
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
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                          ],
                        )),
                    onTap: () {
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
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
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
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                          ],
                        )),
                    onTap: () {
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
        });
  }
}

Widget bottomBar(selectedIndex, context) {
  return BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.apps), label: "Laharana"),
      BottomNavigationBarItem(icon: Icon(Icons.list), label: "Lisitra"),
      BottomNavigationBarItem(icon: Icon(Icons.article), label: "Hira"),
    ],
    currentIndex: selectedIndex,
    onTap: (index) {
      var currentRoute = ModalRoute.of(context)!.settings.name;
      var routes = ['/grid', '/list', '/song'];

      if (currentRoute == routes[index]) {
        return;
      }

      if (index == 2) {
        Navigator.pushNamed(context, routes[index]);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, routes[index], (Route<dynamic> route) => false);
      }

      // if (currentRoute == routes[2] || currentRoute == null) {
      //   Navigator.pushNamedAndRemoveUntil(
      //       context, routes[index], (Route<dynamic> route) => false);
      // }
    },
  );
}

// SongGridViewScreen
class SongGridViewScreen extends StatelessWidget {
  const SongGridViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Laharan\'kira'),
          automaticallyImplyLeading: false,
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
        bottomNavigationBar: bottomBar(0, context));
  }
}

class SongPage extends StatelessWidget {
  const SongPage({super.key, required this.song});

  final Song song;

  @override
  Widget build(BuildContext context) {
    if (song.id != 0) {
      setLatestSong(song);
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
                        "Clé: ${song.key}",
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
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
    } else {
      return FutureBuilder(
          future: getLatestSong(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Scaffold(
                appBar: AppBar(title: const Text("Hira")),
                body: const Center(
                  child: Text("Tsy misy hira voatondro"),
                ),
                bottomNavigationBar: bottomBar(2, context),
              );
            }

            if (snapshot.hasData) {
              var latestSong = snapshot.data;
              return Scaffold(
                appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(65),
                    child: AppBar(
                      title: Column(
                        children: [
                          Text(latestSong.title,
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
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          });
    }
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
