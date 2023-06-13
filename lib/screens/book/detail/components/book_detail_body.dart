import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:momentry/models/book/book_detail.dart';
import 'package:momentry/providers/book/book_detail_provider.dart';

class BookDetailBody extends ConsumerStatefulWidget {
  final int id;

  const BookDetailBody({Key? key, required this.id}) : super(key: key);

  @override
  ConsumerState<BookDetailBody> createState() => _BookDetailBodyState();
}

class _BookDetailBodyState extends ConsumerState<BookDetailBody> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(bookDetailProvider(widget.id).notifier).fetch();
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

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.4,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
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
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Text(
              item.title,
              textAlign: TextAlign.center,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 2,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
              child: Text(
                item.content,
                textAlign: TextAlign.left,
              ),
            ),
          )
        ],
      ),
    );
  }
}
