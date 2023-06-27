class Book {
  final String title; // 책 제목
  final String link; // 네이버 도서 정보 URL
  final String image; // 섬네일 이미지의 URL
  final String author; // 저자 이름
  final String discount; // 판매 가격. 절판 등의 이유로 가격이 없으면 값을 반환하지 않습니다.
  final String publisher; // 출판사
  final String isbn; // ISBN
  final String description; // 네이버 도서의 책 소개
  final String pubdate; // 출간일
  final String content;
  final List<bool> stars;

  Book(
      {required this.title,
      required this.link,
      required this.image,
      required this.author,
      required this.discount,
      required this.publisher,
      required this.isbn,
      required this.description,
      required this.pubdate,
      required this.content,
      required this.stars});

  Book.fromJson(Map<String, dynamic> json, this.content, this.stars)
      : title = json['title'],
        link = json['link'],
        image = json['image'],
        author = json['author'].replaceAll("^", ", "),
        discount = json['discount'],
        publisher = json['publisher'],
        isbn = json['isbn'],
        description = json['description'],
        pubdate = json['pubdate'];
}
