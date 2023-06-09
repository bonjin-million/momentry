import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:momentry/models/movie/movie_detail.dart';
import 'package:momentry/repositories/movie_repository.dart';

final movieDetailProvider = StateNotifierProvider.autoDispose.family<MovieDetailStateNotifier, AsyncValue<MovieDetail>, int>((ref, id) {
  final repository = MovieRepository();
  return MovieDetailStateNotifier(id: id, repository: repository);
});

class MovieDetailStateNotifier extends StateNotifier<AsyncValue<MovieDetail>> {
  final int id;
  final MovieRepository repository;

  MovieDetailStateNotifier({required this.id, required this.repository})
      : super(const AsyncValue.loading());

  Future<void> fetch() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => repository.fetchDetailItem(id));
  }
}
