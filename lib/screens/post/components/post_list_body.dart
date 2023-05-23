import 'package:flutter/material.dart';

class PostListBody extends StatefulWidget {
  const PostListBody({Key? key}) : super(key: key);

  @override
  State<PostListBody> createState() => _PostListBodyState();
}

class _PostListBodyState extends State<PostListBody> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('일기 목록'));
  }
}
