import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:momentry/models/book/book.dart';

class BookAddBody extends StatefulWidget {
  final Book book;
  const BookAddBody({Key? key, required this.book}) : super(key: key);

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
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(50, 0, 50, 25),
                      child: AspectRatio(
                        aspectRatio: 3 / 4,
                        child: Image.network(
                          widget.book.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 40, 10),
                    child: Text(
                      widget.book.title,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 10, 50, 25),
                    child: Container(
                      width: 300,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.blueAccent.withOpacity(0.5))),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 50,
                                  child: Text(
                                    '저자',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                // Text(widget.book.author),
                                Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: Flexible(
                                        child: Text(
                                          widget.book.author,
                                          maxLines: null,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                    width: 50,
                                    child: Text(
                                      '출판사',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    )),
                                Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: Flexible(
                                        child: Text(widget.book.publisher,
                                            textAlign: TextAlign.center),
                                      ),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: Colors.green[500]),
                      Icon(Icons.star, color: Colors.green[500]),
                      Icon(Icons.star, color: Colors.green[500]),
                      Icon(Icons.star, color: Colors.black),
                      Icon(Icons.star, color: Colors.black),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Flexible(
                        child: TextField(
                      maxLines: null,
                      style: TextStyle(decorationThickness: 0),
                      decoration: InputDecoration(
                        hintText: '후기를 작성해주세요.',
                        border: InputBorder.none,
                      ),
                    )),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x10000000),
                    offset: Offset(0, -3),
                    blurRadius: 3,
                    spreadRadius: 0,
                  ),
                ],
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => {},
                    icon: const Icon(Icons.check),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
