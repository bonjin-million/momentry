import 'package:momentry/models/book/book_response.dart';
import 'package:momentry/repositories/book_repository.dart';
import 'package:riverpod/riverpod.dart';

final bookProvider = StateNotifierProvider.autoDispose<BookStateNotifier,
    AsyncValue<BookResponse>>((ref) {
  final repository = BookRepository();
  return BookStateNotifier(repository: repository);
});

class BookStateNotifier extends StateNotifier<AsyncValue<BookResponse>> {
  final BookRepository repository;

  BookStateNotifier({
    required this.repository,
  }) : super(const AsyncLoading());

  Future<void> fetchItems({required String keyword}) async {
    state =
        await AsyncValue.guard(() => repository.fetchItems(keyword: keyword));
  }
}
