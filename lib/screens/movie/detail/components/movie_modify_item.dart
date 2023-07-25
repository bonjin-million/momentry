import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:momentry/models/movie/movie_detail.dart';
import 'package:momentry/providers/movie/movie_detail_provider.dart';
import 'package:momentry/screens/movie/add/movie_add_screen.dart';

import '../../../../providers/movie/movie_list_provider.dart';

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

  void delete() async {
    ref.read(movieListProvider.notifier).delete(widget.id).then((value) {
      Navigator.popUntil(context, (route) => route.isFirst);
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
            height: 85,
            width: 120,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MovieAddScreen(item: item, type: 'MODIFY'),
                            fullscreenDialog: true,
                          ),
                        );
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
                  const SizedBox(
                    height: 5,
                  ),
                  InkWell(
                      onTap: () {
                        showAlert();
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

  void showAlert() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: const Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [Text('정말 삭제하시나요?'), Text('(삭제된 데이터는 복원되지 않아요)')],
              ),
            ),
            actions: [
              TextButton(
                child: const Text("취소"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text("확인"),
                onPressed: () {
                  delete();
                },
              ),
            ],
          );
        });
  }
}
