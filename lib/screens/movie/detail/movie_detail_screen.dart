import 'package:flutter/material.dart';
import 'package:momentry/models/movie/movie_detail.dart';
import 'package:momentry/screens/movie/detail/components/movie_detail_body.dart';
import 'package:momentry/screens/movie/detail/components/movie_modify_item.dart';

class MovieDetailScreen extends StatefulWidget {
  final int id;
  final MovieDetail? item;

  const MovieDetailScreen({Key? key, required this.id, this.item})
      : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
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
        MovieDetailBody(id: widget.id),
        MovieModifyItem(isVisible: isVisible, id: widget.id),
      ]),
    );
  }
}
