import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:momentry/models/movie/movie.dart';
import 'package:momentry/models/movie/movie_add_request.dart';
import 'package:momentry/models/movie/movie_credits_response.dart';
import 'package:momentry/models/movie/movie_detail.dart';
import 'package:momentry/providers/movie/movie_list_provider.dart';
import 'package:momentry/providers/movie_credits_provider.dart';
import 'package:momentry/widgets/custom_image.dart';

class MovieAddBody extends ConsumerStatefulWidget {
  final Movie? item;
  final MovieDetail? detailItem;

  const MovieAddBody({Key? key, this.item, this.detailItem}) : super(key: key);

  @override
  ConsumerState<MovieAddBody> createState() => _MovieAddBodyState();
}

class _MovieAddBodyState extends ConsumerState<MovieAddBody> {
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
    if (widget.item != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ref
            .read(movieCreditsProvider.notifier)
            .fetchItemDetail(id: widget.item!.id);
      });
    } else {
      if (widget.detailItem!.stars.isNotEmpty) {
        stars = widget.detailItem!.stars;
      }
    }
  }

  void add(String directors, String actors) async {
    final currentState = _formKey.currentState!;

    if (currentState.validate()) {
      currentState.save();

      final newMoviePost = MovieAddRequest(
        title: widget.item?.title ?? '',
        movieId: widget.item?.id ?? 0,
        image: widget.item?.posterPath ?? '',
        stars: stars,
        directors: directors,
        actors: actors,
        content: content,
        date: date,
        prodYear: widget.item?.releaseDate ?? '',
      );

      ref
          .read(movieListProvider.notifier)
          .add(newMoviePost.toMap())
          .then((value) {
        Navigator.popUntil(context, (route) => route.isFirst);
      });
    }
  }

  void update(String directors, String actors) async {
    final currentState = _formKey.currentState!;

    if (currentState.validate()) {
      currentState.save();

      final newMoviePost = MovieAddRequest(
          title: widget.detailItem?.title ?? '',
          movieId: widget.detailItem?.id ?? 0,
          image: widget.detailItem?.image ?? '',
          stars: stars,
          directors: directors,
          actors: actors,
          content: content,
          date: date,
          prodYear: widget.detailItem?.prodYear ?? '');

      ref
          .read(movieListProvider.notifier)
          .update(newMoviePost.toMap(), widget.detailItem!.id)
          .then((value) {
        Navigator.popUntil(context, (route) => route.isFirst);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String? actors = '';
    String? directors = '';
    String? image = '';
    String? releaseDate = '';
    String? title = '';

    if (widget.item != null) {
      final state = ref.watch(movieCreditsProvider);
      final isData = state is AsyncData<MovieCreditsResponse>;
      final isLoading = state is AsyncLoading;
      final isError = state is AsyncError;

      if (isLoading || !isData) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (isError) {
        return const Center(
          child: Text('오류!'),
        );
      }

      final credits = state.value;
      actors = credits.cast.map((e) => e.name).join(", ");
      directors = credits.crew
          .where((e) => e.job == 'Director')
          .map(
            (e) => e.name ?? '',
          )
          .join(", ");
      image = widget.item?.posterPath;
      releaseDate = widget.item?.releaseDate;
      title = widget.item?.title;
    } else {
      actors = widget.detailItem?.actors;
      directors = widget.detailItem?.directors;
      image = widget.detailItem?.image;
      releaseDate = widget.detailItem?.prodYear;
      title = widget.detailItem?.title;
    }

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
                              imageUrl: image ?? '',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 40, 10),
                        child: Text(
                          title ?? '',
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    Text(releaseDate ?? ''),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      child: Wrap(children: [
                                        Text(
                                          directors ?? '',
                                          textAlign: TextAlign.center,
                                        )
                                      ]),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      child: Wrap(children: [
                                        Text(
                                          actors ?? '',
                                          textAlign: TextAlign.left,
                                        )
                                      ]),
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
                            if (value != null) {
                              content = value;
                            }
                          },
                          initialValue: widget.detailItem?.content ?? '',
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
                      onPressed: () {
                        widget.item != null
                            ? add(directors ?? '', actors ?? '')
                            : update(directors ?? '', actors ?? '');
                      },
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
