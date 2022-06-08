import 'bottom_bar.dart';
import 'song_screen.dart';
import 'squared_button.dart';
import 'database_helper.dart';
import 'package:flutter/material.dart';

// SongGridViewScreen
class NumbersGridScreen extends StatelessWidget {
  const NumbersGridScreen({super.key});

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
                return gridViewBuilder(snapshot);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
        bottomNavigationBar: bottomBar(0, context));
  }

  GridView gridViewBuilder(AsyncSnapshot<dynamic> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
        itemBuilder: (BuildContext context, int index) {
          return SquaredButton(
            character: snapshot.data[index].number.toString(),
            size: 20.0,
            borderWidth: 1.0,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SongScreen(
                    song: snapshot.data[index],
                  ),
                ),
              );
            },
          );
        });
  }
}
