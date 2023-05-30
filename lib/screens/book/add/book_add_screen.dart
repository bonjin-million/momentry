import 'package:flutter/material.dart';
import 'package:momentry/models/book/book.dart';
import 'package:momentry/screens/book/add/components/book_add_body.dart';

class BookAddScreen extends StatefulWidget {
  const BookAddScreen({Key? key, required this.book}) : super(key: key);
  final Book book;

  @override
  State<BookAddScreen> createState() => _BookAddScreenState();
}

class _BookAddScreenState extends State<BookAddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('책 후기 작성'),
      ),
      body: BookAddBody(book: (widget.book)),
    );
  }
}
