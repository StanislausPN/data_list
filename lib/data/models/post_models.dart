class PostModels {
  final int? userId;
  final int? id;
  final String? title;
  final String? body;

  PostModels({this.userId, this.id, this.title, this.body});

  static PostModels fromJson(Map<String, dynamic> json) {
    return PostModels(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
