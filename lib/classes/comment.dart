class Comment {
  int id;
  int postId;
  String name;
  String body;

  Comment({
    required this.id,
    required this.postId,
    required this.name,
    required this.body,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        postId: json["postId"],
        name: json["name"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "postId": postId,
        "name": name,
        "body": body,
      };
}
