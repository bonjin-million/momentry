import 'package:flutter/material.dart';
import 'package:momentry/screens/movie/detail/components/movie_detail_body.dart';
import 'package:momentry/screens/movie/detail/components/movie_modify_item.dart';

class MovieDetailScreen extends StatefulWidget {
  final int id;

  const MovieDetailScreen({Key? key, required this.id}) : super(key: key);

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
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Stack(children: [
        MovieModifyItem(isVisible: isVisible, id: widget.id),
        MovieDetailBody(id: widget.id)
      ]),
    );
  }
}
