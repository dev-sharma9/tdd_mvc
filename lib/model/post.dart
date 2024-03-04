import 'dart:convert';

class Post {
  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
    required this.link,
    required this.commentCount,
  });

  final int? userId;
  final int? id;
  final String? title;
  final String? body;
  final String? link;
  final int? commentCount;

  factory Post.fromJson(Map<String, dynamic> json){
    return Post(
      userId: json["userId"],
      id: json["id"],
      title: json["title"],
      body: json["body"],
      link: json["link"],
      commentCount: json["comment_count"],
    );
  }
}
List<Post> parsePosts(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Post>((json) => Post.fromJson(json)).toList();
}
