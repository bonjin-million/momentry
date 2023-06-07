import 'package:flutter/material.dart';
import 'package:momentry/screens/book/detail/components/book_detail_body.dart';

class BookDetailScreen extends StatelessWidget {
  final int id;
  const BookDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: BookDetailBody(id: id),
    );
  }
}
