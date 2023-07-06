import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:momentry/models/movie/movie_detail.dart';
import 'package:momentry/providers/movie/movie_detail_provider.dart';

class MovieDetailBody extends ConsumerStatefulWidget {
  final int id;

  const MovieDetailBody({Key? key, required this.id}) : super(key: key);

  @override
  ConsumerState<MovieDetailBody> createState() => _BookDetailBodyState();
}

class _BookDetailBodyState extends ConsumerState<MovieDetailBody> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(movieDetailProvider(widget.id).notifier).fetch();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(movieDetailProvider(widget.id));

    final isData = state is AsyncData<MovieDetail>;
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

    final item = state.value;
    final actors = item.actors.map((e) => e.actorNm).join(", ");

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: AspectRatio(
              aspectRatio: 3 / 4,
              child: Image.network(
                item.image,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
            child: Text(
              item.title,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
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
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    // Text(widget.book.author),
                    Expanded(
                      child: Text(
                        item.prodYear,
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
                        children: item.directors
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
                        children: [Text(actors, textAlign: TextAlign.center)],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: item.stars.asMap().entries.map(
                (e) {
                  bool value = e.value;

                  return Icon(
                    value ? Icons.star : Icons.star_border_outlined,
                    color: value ? Colors.amber : Colors.grey,
                    size: 15,
                  );
                },
              ).toList(),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 3,
            color: Colors.black12,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: Text(
                  item.content,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}