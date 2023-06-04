import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:momentry/models/book/book.dart';
import 'package:momentry/repositories/book_repository.dart';

final bookDetailProvider = StateNotifierProvider.autoDispose
    .family<BookDetailStateNotifier, AsyncValue<Book>, int>((ref, id) {
  final repository = BookRepository();
  return BookDetailStateNotifier(id: id, repository: repository);
});

class BookDetailStateNotifier extends StateNotifier<AsyncValue<Book>> {
  final int id;
  final BookRepository repository;

  BookDetailStateNotifier({required this.id, required this.repository})
      : super(const AsyncValue.loading());
}
