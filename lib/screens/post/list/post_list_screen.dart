import 'package:flutter/material.dart';
import 'package:momentry/screens/post/list/components/post_list_body.dart';
import 'package:momentry/screens/post/add/post_add_screen.dart';

class PostListScreen extends StatelessWidget {
  const PostListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('일기'),
      ),
      body: PostListBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostAddScreen(),
            ),
          );
        },
        child: const Icon(Icons.add_circle_outline_sharp),
      ),
    );
  }
}
