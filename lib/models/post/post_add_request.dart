class PostAddRequest {
  final String title;
  final String content;
  final String date;

  PostAddRequest({
    required this.title,
    required this.content,
    required this.date,
  });

  PostAddRequest.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        content = json['content'],
        date = json['date'];

  Map<String, dynamic> toMap() =>
      {'title': title, 'content': content, 'date': date};
}
