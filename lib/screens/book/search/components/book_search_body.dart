import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:momentry/models/book/book_response.dart';
import 'package:momentry/providers/book_provider.dart';
import 'package:momentry/screens/book/search/components/book_search_item.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class BookSearchBody extends ConsumerWidget {
  const BookSearchBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bookProvider);
    final isData = state is AsyncData<BookResponse>;
    final isLoading = state is AsyncLoading;
    final isError = state is AsyncError;

    if (isLoading || !isData) {
      return Container();
    }

    if (isError) {
      return const Center(
        child: Text('오류!'),
      );
    }

    final data = state.value;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SafeArea(
        child: MasonryGridView.count(
          padding: const EdgeInsets.all(16),
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 8,
          itemCount: data.items.length,
          itemBuilder: (context, index) {
            final item = data.items[index];
            return BookSearchItem(
              item: item,
            );
          },
        ),
      ),
    );
  }
}
