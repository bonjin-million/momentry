class BookAddRequest {
  final String title;
  final String image;
  final List<dynamic> stars;
  final String author;
  final String publisher;
  final String content;
  final String date;

  BookAddRequest(
      {required this.title,
      required this.image,
      required this.stars,
      required this.author,
      required this.publisher,
      required this.content,
      required this.date});

  BookAddRequest.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        content = json['content'],
        date = json['date'],
        publisher = json['publisher'],
        author = json['author'],
        stars = json['stars'],
        image = json['image'];

  Map<String, dynamic> toMap() => {
        'title': title,
        'image': image,
        'stars': stars.toString(),
        'author': author,
        'publisher': publisher,
        'content': content,
        'date': date,
      };
}
