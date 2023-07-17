import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:momentry/repositories/movie_repository.dart';

import '../models/movie/movie_credits_response.dart';

final movieCreditsProvider = StateNotifierProvider.autoDispose<
    MovieCreditsStateNotifier, AsyncValue<MovieCreditsResponse>>((ref) {
  final repository = MovieRepository();
  return MovieCreditsStateNotifier(repository: repository);
});

class MovieCreditsStateNotifier
    extends StateNotifier<AsyncValue<MovieCreditsResponse>> {
  final MovieRepository repository;

  MovieCreditsStateNotifier({
    required this.repository,
  }) : super(const AsyncLoading());

  Future<void> fetchItemDetail({required int id}) async {
    state = await AsyncValue.guard(() => repository.fetchItemDetail(id: id));
  }
}
