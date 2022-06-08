import 'bottom_bar.dart';
import 'database_helper.dart';
import 'package:flutter/material.dart';
import 'song_screen.dart';
import 'song_search_delegate.dart';

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
