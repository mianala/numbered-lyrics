import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'song.dart';

void setLatestSong(song) async {
  // save latest song as json
  final prefs = await SharedPreferences.getInstance();
  final json = song.toJson();
  final jsonString = jsonEncode(json);
  prefs.setString('latestSong', jsonString);
}

Future<Song?> getLatestSong() async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = prefs.getString('latestSong');
  if (jsonString == null) {
    return null;
  }

  return Song.fromJson(jsonString);
}
