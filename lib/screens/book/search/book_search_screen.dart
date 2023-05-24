import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:momentry/providers/book_provider.dart';
import 'package:momentry/screens/book/search/components/book_search_body.dart';

class BookSearchScreen extends ConsumerStatefulWidget {
  const BookSearchScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<BookSearchScreen> createState() => _BookSearchScreenState();
}

class _BookSearchScreenState extends ConsumerState<BookSearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: TextField(
          controller: _searchController,
          decoration:  InputDecoration(
            hintText: '책 검색',
            border: InputBorder.none,
            suffixIcon: Visibility(
              visible: _searchController.text.isNotEmpty,
              child: IconButton(
                icon: const Icon(Icons.clear_outlined),
                onPressed: () {
                  setState(() {
                    _searchController.clear();
                  });
                },
              ),
            ),
          ),
          onChanged: (value) {
            setState(() {});
          },
          autofocus: true,
          onSubmitted: (value) {
            if(value.isNotEmpty) {
              ref.read(bookProvider.notifier).fetchItems(keyword: value);
            }
          },
        ),
        centerTitle: false,
      ),
      body: BookSearchBody(),
    );
  }
}
