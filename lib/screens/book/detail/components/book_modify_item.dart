import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:momentry/models/book/book.dart';
import 'package:momentry/models/book/book_detail.dart';
import 'package:momentry/providers/book/book_detail_provider.dart';
import 'package:momentry/screens/book/add/book_add_screen.dart';
import 'package:momentry/providers/book/book_list_provider.dart';

class BookModifyItem extends ConsumerStatefulWidget {
  final bool isVisible;
  final int id;
  const BookModifyItem({Key? key, required this.isVisible, required this.id})
      : super(key: key);

  @override
  ConsumerState<BookModifyItem> createState() => _BookModifyItemState();
}

class _BookModifyItemState extends ConsumerState<BookModifyItem> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(bookDetailProvider(widget.id).notifier).fetch();
    });
  }

  void delete() async {
    ref.read(bookListProvider.notifier).delete(widget.id).then((value) {
      Navigator.popUntil(context, (route) => route.isFirst);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bookDetailProvider(widget.id));

    final isData = state is AsyncData<BookDetail>;
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

    final book = Book(
        title: item.title,
        link: '',
        image: item.image,
        author: item.author,
        discount: '',
        publisher: item.publisher,
        isbn: '',
        description: '',
        content: item.content,
        stars: item.stars,
        pubdate: '');

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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                BookAddScreen(item: book, id: item.id),
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
                  InkWell(
                      onTap: () {
                        delete();
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
