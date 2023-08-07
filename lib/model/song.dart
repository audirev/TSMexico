class Song {
  final String id;
  final String name;

  const Song({
    required this.id,
    required this.name
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'],
      name: json['name'],
    );
  }
}