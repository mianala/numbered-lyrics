import 'song.dart';
import 'database_helper.dart';
import 'package:flutter/material.dart';
import 'shared_preferences.dart';
import 'song_screen.dart';

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
        close(context, const Song());
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
