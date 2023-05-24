import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:momentry/providers/movie_provider.dart';
import 'package:momentry/screens/movie/search/components/movie_search_body.dart';

class MovieSearchScreen extends ConsumerStatefulWidget {
  const MovieSearchScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MovieSearchScreen> createState() => _MovieSearchScreenState();
}

class _MovieSearchScreenState extends ConsumerState<MovieSearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: TextField(
          controller: _searchController,
          decoration:  InputDecoration(
            hintText: '영화 검색',
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
              ref.read(movieProvider.notifier).fetchItems(keyword: value);
            }
          },
        ),
        centerTitle: false,
      ),
      body: MovieSearchBody(),
    );
  }
}
