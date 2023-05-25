import 'package:flutter/material.dart';

class BookAddBody extends StatefulWidget {
  const BookAddBody({Key? key}) : super(key: key);

  @override
  State<BookAddBody> createState() => _BookAddBodyState();
}

class _BookAddBodyState extends State<BookAddBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('도서 정보 가져오기 + 후기 기록'),
    );
  }
}
