class Post {
  final int id;
  final String title;
  final String content;

  const Post({
    required this.id,
    required this.title,
    required this.content,
  });

  Post.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        content = json['content'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'content': content,
  };
}