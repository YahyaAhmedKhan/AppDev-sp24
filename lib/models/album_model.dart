class Album {
// "userId": 1,
// "id": 1,
// "title":
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromjson(Map<String, dynamic> json) {
    return Album(
      userId: json["userId"],
      id: json["id"],
      title: json["title"],
    );
  }
}
