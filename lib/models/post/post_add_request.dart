class PostAddRequest {
  final String title;
  final String content;

  PostAddRequest({
    required this.title,
    required this.content,
  });

  PostAddRequest.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        content = json['content'];

  Map<String, dynamic> toMap() => {
    'title': title,
    'content': content,
  };
}