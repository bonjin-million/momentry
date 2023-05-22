import 'package:flutter/material.dart';
import 'package:momentry/screens/book/book_screen.dart';
import 'package:momentry/screens/post/post_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BookScreen()));
            },
            child: Text('도서 정보 검색'),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PostListScreen()));
            },
            child: Text('POST 화면 이동'),
          ),
        ],
      ),
    );
  }
}
