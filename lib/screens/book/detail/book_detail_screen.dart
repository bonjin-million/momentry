import 'package:flutter/material.dart';
import 'package:momentry/screens/book/detail/components/book_detail_body.dart';
import 'package:momentry/screens/book/detail/components/book_modify_item.dart';

class BookDetailScreen extends StatefulWidget {
  final int id;
  const BookDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isVisible = !isVisible;
              });
            },
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Stack(children: [
        BookDetailBody(id: widget.id),
        BookModifyItem(isVisible: isVisible, id: widget.id)
      ]),
    );
  }
}
