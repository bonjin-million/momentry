import 'package:flutter/material.dart';
import 'package:momentry/screens/book/components/book_body.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('책'),
        centerTitle: false,
      ),
      body: BookBody(),
    );
  }
}
