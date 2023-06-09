import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:momentry/models/book/book.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:momentry/models/book/book_add_request.dart';
import 'package:momentry/models/movie/movie.dart';
import 'package:momentry/models/movie/movie_add_request.dart';
import 'package:momentry/providers/book/book_list_provider.dart';
import 'package:momentry/providers/movie/movie_list_provider.dart';
import 'package:momentry/widgets/custom_image.dart';

class MovieAddBody extends ConsumerStatefulWidget {
  final Movie item;

  const MovieAddBody({Key? key, required this.item}) : super(key: key);

  @override
  ConsumerState<MovieAddBody> createState() => _BookAddBodyState();
}

class _BookAddBodyState extends ConsumerState<MovieAddBody> {
  final _formKey = GlobalKey<FormState>();
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
    final currentState = _formKey.currentState!;

    if (currentState.validate()) {
      currentState.save();

      final newMoviePost = MovieAddRequest(
        title: widget.item.title,
        image: widget.item.posters.firstOrNull?.imageUrl ?? '',
        stars: stars,
        author: widget.item.directors.toString(),
        publisher: widget.item.actors.toString(),
        content: content,
        date: date,
      );

      ref
          .read(movieListProvider.notifier)
          .add(newMoviePost.toMap())
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
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(50, 0, 50, 25),
                          child: AspectRatio(
                            aspectRatio: 3 / 4,
                            child: CustomImage(
                              imageUrl: widget.item.posters.firstOrNull?.imageUrl ?? '',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 40, 10),
                        child: Text(
                          widget.item.title,
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
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 50,
                                      child: Text(
                                        '개봉',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    // Text(widget.book.author),
                                    Expanded(
                                      child: Text(
                                        widget.item.prodYear,
                                        maxLines: null,
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
                                        '감독',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Wrap(
                                        children: widget.item.directors
                                            .map((e) => Text(
                                                  e.directorNm,
                                                  textAlign: TextAlign.center,
                                                ))
                                            .toList(),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 50,
                                      child: Text(
                                        '배우',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Wrap(
                                        children: widget.item.actors
                                            .map((e) => Text(
                                          e.actorNm,
                                          textAlign: TextAlign.center,
                                        ))
                                            .toList(),
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
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
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
