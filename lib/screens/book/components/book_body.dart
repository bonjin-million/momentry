import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:momentry/models/book/book_response.dart';
import 'package:momentry/providers/book_provider.dart';
import 'package:momentry/screens/book/components/book_item.dart';

class BookBody extends ConsumerStatefulWidget {
  const BookBody({Key? key}) : super(key: key);

  @override
  ConsumerState<BookBody> createState() => _BookBodyState();
}

class _BookBodyState extends ConsumerState<BookBody> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(bookProvider.notifier).fetchItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bookProvider);
    final isData = state is AsyncData<BookResponse>;
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

    final data = state.value;

    return ListView.builder(
      itemBuilder: (context, index) {
        final item = data.items[index];
        return BookItem(
          item: item,
        );
      },
      itemCount: data.items.length,
    );
  }
}
