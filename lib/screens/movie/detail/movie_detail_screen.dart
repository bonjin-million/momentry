import 'package:flutter/material.dart';
import 'package:momentry/screens/movie/detail/components/movie_detail_body.dart';

class MovieDetailScreen extends StatelessWidget {
  final int id;
  const MovieDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: MovieDetailBody(id: id),
    );
  }
}
