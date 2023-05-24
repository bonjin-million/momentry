class Post {
  final int id;
  final String title;
  final String content;
  final String date;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
  });

  Post.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        content = json['content'],
        date = json['date'];

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'content': content,
        'date': date,
      };
}
