class Song {
  final int id;
  final int number;
  final String content;
  final String title;
  final String key;
  final int verses;

  const Song({
    required this.id,
    required this.number,
    required this.verses,
    required this.title,
    required this.content,
    required this.key,
  });

  static fromMap(Map<String, dynamic> map) {
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
