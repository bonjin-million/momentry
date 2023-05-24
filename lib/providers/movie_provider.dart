import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:momentry/models/movie/movie_response.dart';
import 'package:momentry/repositories/movie_repository.dart';

final movieProvider = StateNotifierProvider.autoDispose<BookStateNotifier, AsyncValue<MovieResponse>>((ref) {
  final repository = MovieRepository();
  return BookStateNotifier(repository: repository);
});

class BookStateNotifier extends StateNotifier<AsyncValue<MovieResponse>> {
  final MovieRepository repository;

  BookStateNotifier({
    required this.repository,
  }) : super(const AsyncLoading());

  Future<void> fetchItems({required String keyword}) async {
    state = await AsyncValue.guard(() => repository.fetchItems(keyword: keyword));
  }
}
