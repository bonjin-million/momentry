import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:momentry/models/book/book.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:momentry/models/book/book_add_request.dart';
import 'package:momentry/providers/book/book_list_provider.dart';

class BookAddBody extends ConsumerStatefulWidget {
  final Book book;

  const BookAddBody({Key? key, required this.book}) : super(key: key);

  @override
  ConsumerState<BookAddBody> createState() => _BookAddBodyState();
}

class _BookAddBodyState extends ConsumerState<BookAddBody> {
  final _bookKey = GlobalKey<FormState>();
  List<bool> stars = List.generate(5, (index) => index < 3);
  String content = '';
  String date = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    });
  }

  void add() async {
    final bookKeyState = _bookKey.currentState!;

    if (bookKeyState.validate()) {
      bookKeyState.save();

      final newBookPost = BookAddRequest(
        title: widget.book.title,
        image: widget.book.image,
        stars: stars,
        author: widget.book.author,
        publisher: widget.book.publisher,
        content: content,
        date: date,
      );

      ref
          .read(bookListProvider.notifier)
          .add(newBookPost.toMap())
          .then((value) {
        Navigator.popUntil(context, (route) => route.isFirst);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _bookKey,
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
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
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50, 10, 50, 25),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blueAccent.withOpacity(0.5),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(
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
                                    Expanded(
                                      child: Text(
                                        widget.book.author,
                                        maxLines: null,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 50,
                                      child: Text(
                                        '출판사',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        widget.book.publisher,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ...stars.asMap().entries.map(
                              (e) {
                                int index = e.key;
                                bool value = e.value;
                                return InkWell(
                                  onTap: () {
                                    var newStars = [...stars.map((e) => false)];

                                    for (int i = 0; i <= index; i++) {
                                      newStars[i] = true;
                                    }

                                    setState(() {
                                      stars = newStars;
                                    });
                                  },
                                  child: Icon(
                                    value
                                        ? Icons.star
                                        : Icons.star_border_outlined,
                                    color: value ? Colors.amber : Colors.grey,
                                  ),
                                );
                              },
                            ).toList(),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: TextFormField(
                          onSaved: (value) {
                            print(value);
                            if (value != null) {
                              content = value;
                            }
                          },
                          autofocus: true,
                          maxLines: null,
                          style: const TextStyle(decorationThickness: 0),
                          decoration: const InputDecoration(
                            hintText: '후기를 작성해주세요.',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
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
                      onPressed: add,
                      icon: const Icon(Icons.check),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
