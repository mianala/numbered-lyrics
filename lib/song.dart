import 'dart:convert';

class Song {
  final int id;
  final int number;
  final String content;
  final String title;
  final String key;
  final int verses;

  const Song({
    this.id = 0,
    this.number = 0,
    this.verses = 0,
    this.title = "Lohateny",
    this.content = "Tononkira",
    this.key = "C",
  });

  static fromMap(Map<String, dynamic> map) {
    return Song(
      id: int.tryParse(map['id']) ?? 0,
      number: int.tryParse(map['number']) ?? 0,
      title: map['title'],
      content: map['content'],
      key: map['key'],
      verses: int.tryParse(map['verses']) ?? 0,
    );
  }

  toJson() {
    return {
      'id': id,
      'number': number,
      'title': title,
      'content': content,
      'key': key,
      'verses': verses,
    };
  }

  static fromJson(String json) {
    final map = jsonDecode(json);
    return Song(
      id: map['id'],
      number: map['number'],
      title: map['title'],
      content: map['content'],
      key: map['key'],
      verses: map['verses'],
    );
  }
}
