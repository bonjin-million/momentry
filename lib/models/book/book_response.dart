import 'book.dart';

class BookResponse {
  final String lastBuildDate;
  final int total;
  final int start;
  final int display;
  final List<Book> items;

  BookResponse({
    required this.lastBuildDate,
    required this.total,
    required this.start,
    required this.display,
    required this.items,
  });

  BookResponse.fromJson(Map<String, dynamic> json)
      : lastBuildDate = json['lastBuildDate'],
        total = json['total'],
        start = json['start'],
        display = json['display'],
        items = (json['items'] as List).map((e) => Book.fromJson(e)).toList();
}
