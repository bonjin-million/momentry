import 'package:flutter/material.dart';
import 'package:momentry/screens/post/components/post_list_body.dart';

class PostListScreen extends StatelessWidget {
  const PostListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('POST'),
      ),
      body: PostListBody(),
    );
  }
}
