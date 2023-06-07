import 'package:flutter/material.dart';
import 'package:momentry/screens/post/detail/components/post_detail_body.dart';

class PostDetailScreen extends StatelessWidget {
  final int id;

  const PostDetailScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: PostDetailBody(id: id,),
    );
  }
}
