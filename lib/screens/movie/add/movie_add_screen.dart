import 'package:flutter/material.dart';
import 'package:momentry/models/movie/movie.dart';
import 'package:momentry/screens/movie/add/components/movie_add_body.dart';

class MovieAddScreen extends StatefulWidget {
  const MovieAddScreen({Key? key, required this.item}) : super(key: key);
  final Movie item;

  @override
  State<MovieAddScreen> createState() => _MovieAddScreenState();
}

class _MovieAddScreenState extends State<MovieAddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('책 후기 작성'),
      ),
      body: MovieAddBody(item: (widget.item)),
    );
  }
}
