import 'package:flutter/material.dart';
import 'package:momentry/screens/post/components/post_list_body.dart';
import 'package:momentry/screens/post/post_screen.dart';

class PostListScreen extends StatelessWidget {
  const PostListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('POST'),
      ),
      body: PostListBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PostScreen()));
        },
        child: Icon(Icons.add_circle_outline_sharp),
      ),
    );
  }
}
