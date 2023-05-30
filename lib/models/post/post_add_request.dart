class PostAddRequest {
  final String title;
  final String content;
  final String date;
  final String imageFile;

  PostAddRequest({
    required this.title,
    required this.content,
    required this.date,
    required this.imageFile,
  });

  PostAddRequest.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        content = json['content'],
        date = json['date'],
        imageFile = json['imageFile'];

  Map<String, dynamic> toMap() =>
      {'title': title, 'content': content, 'date': date, 'imageFile': imageFile};
}
