import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('일기 작성'),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
        child: Column(
          children: [
            SizedBox(
                child: Text(
              '2023.05.23',
              style: TextStyle(fontSize: 17),
            )),
            Expanded(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      autofocus: true,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: '일기 작성하는 곳',
                        border: InputBorder.none,
                      ),
                    ))),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.check),
                      onPressed: () {},
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
