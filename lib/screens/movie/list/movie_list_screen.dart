import 'package:flutter/material.dart';
import 'package:momentry/screens/movie/search/movie_search_screen.dart';

class MovieListScreen extends StatelessWidget {
  const MovieListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('영화'),
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => MovieSearchScreen(),),);
          }, icon: const Icon(Icons.add),),
        ],
      ),
    );
  }
}
