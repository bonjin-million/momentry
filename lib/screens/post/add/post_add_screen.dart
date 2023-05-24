import 'package:flutter/material.dart';
import 'package:momentry/screens/post/add/components/post_add_body.dart';

class PostAddScreen extends StatefulWidget {
  const PostAddScreen({Key? key}) : super(key: key);

  @override
  State<PostAddScreen> createState() => _PostAddScreenState();
}

class _PostAddScreenState extends State<PostAddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('일기 작성'),
      ),
      body: PostAddBody(),
    );
  }
}
