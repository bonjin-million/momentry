import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:momentry/models/movie/movie_detail.dart';
import 'package:momentry/providers/movie/movie_detail_provider.dart';

class MovieModifyItem extends ConsumerStatefulWidget {
  final bool isVisible;
  final int id;
  const MovieModifyItem({Key? key, required this.isVisible, required this.id})
      : super(key: key);

  @override
  ConsumerState<MovieModifyItem> createState() => _MovieModifyItemState();
}

class _MovieModifyItemState extends ConsumerState<MovieModifyItem> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(movieDetailProvider(widget.id).notifier).fetch();
    });
  }

  // void delete() async {
  //   ref.read(movieListProvider.notifier).delete(widget.id).then((value) {
  //     Navigator.popUntil(context, (route) => route.isFirst);
  //   });
  // }

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

    print("item ===  $item ");

    // final movie = MovieDetail(
    //     id: item.id,
    //     title: item.title,
    //     image: item.image,
    //     stars: item.stars,
    //     author: item.author,
    //     publisher: item.publisher,
    //     content: item.content,
    //     date: item.date);

    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Visibility(
          visible: widget.isVisible,
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  width: 0,
                  color: Colors.white30,
                )),
            height: 80,
            width: 120,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //         MovieAddScreen(item: movie, id: item.id),
                        //     fullscreenDialog: true,
                        //   ),
                        // );
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.mode_edit),
                          SizedBox(
                            width: 3,
                          ),
                          Text("수정하기"),
                        ],
                      )),
                  InkWell(
                      onTap: () {
                        // delete();
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.delete),
                          SizedBox(
                            width: 3,
                          ),
                          Text("삭제하기"),
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
