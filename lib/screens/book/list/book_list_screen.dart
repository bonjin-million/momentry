import 'package:flutter/material.dart';
import 'package:momentry/screens/book/search/book_search_screen.dart';

class BookListScreen extends StatelessWidget {
  const BookListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('책'),
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => BookSearchScreen(),),);
          }, icon: const Icon(Icons.add),),
        ],
      ),
    );
  }
}
