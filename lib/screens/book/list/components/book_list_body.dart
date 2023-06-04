import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:momentry/models/book/book_detail.dart';
import 'package:momentry/providers/book/book_list_provider.dart';
import 'package:momentry/screens/book/list/components/book_list_item.dart';

class BookListBody extends ConsumerStatefulWidget {
  const BookListBody({Key? key}) : super(key: key);

  @override
  ConsumerState<BookListBody> createState() => _BookListBodyState();
}

class _BookListBodyState extends ConsumerState<BookListBody> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(bookListProvider.notifier).findAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bookListProvider);
    final isData = state is AsyncData<List<BookDetail>>;
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

    final items = state.value;

    if (items.isEmpty) {
      return Center(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/panic.png',
                width: MediaQuery.of(context).size.width * 0.2,
              ),
              const SizedBox(
                height: 24,
              ),
              const Text('등록된 책이 없어요'),
            ],
          ),
        ),
      );
    }

    // return BookListItem(
    //   item: item,
    //   onTap: () {},
    // );

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SafeArea(
        child: MasonryGridView.count(
            crossAxisCount: 3,
            padding: const EdgeInsets.all(16),
            mainAxisSpacing: 16,
            crossAxisSpacing: 8,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return BookListItem(item: item);
            }),
      ),
    );
  }
}
