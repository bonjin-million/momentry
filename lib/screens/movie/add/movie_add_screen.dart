import 'package:flutter/material.dart';
import 'package:momentry/models/movie/movie.dart';
import 'package:momentry/models/movie/movie_detail.dart';
import 'package:momentry/screens/movie/add/components/movie_add_body.dart';

class MovieAddScreen extends StatefulWidget {
  const MovieAddScreen({Key? key, this.item, required this.type})
      : super(key: key);
  final MovieDetail? item;
  final String type;

  @override
  State<MovieAddScreen> createState() => _MovieAddScreenState();
}

class _MovieAddScreenState extends State<MovieAddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('영화 후기 작성'),
      ),
      body: MovieAddBody(item: widget.item, type: widget.type),
    );
  }
}
