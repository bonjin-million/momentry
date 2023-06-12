import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:momentry/models/book/book_detail.dart';
import 'package:momentry/repositories/book_repository.dart';

final bookListProvider = StateNotifierProvider((ref) {
  final repository = BookRepository();
  return BookListStateNotifier(repository: repository);
});

class BookListStateNotifier
    extends StateNotifier<AsyncValue<List<BookDetail>>> {
  final BookRepository repository;

  BookListStateNotifier({required this.repository})
      : super(const AsyncValue.loading());

  Future<void> findAll() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => repository.fetchList());
  }

  Future<void> add(Map<String, dynamic> bookAddRequest) async {
    await repository.add(bookAddRequest);
    findAll();
  }

  Future<void> update(Map<String, dynamic> bookAddRequest, int id) async {
    await repository.update(bookAddRequest, id);
    findAll();
  }

  Future<void> delete(int id) async {
    await repository.delete(id);
    findAll();
  }
}
