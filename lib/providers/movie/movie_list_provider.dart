import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:momentry/models/movie/movie_detail.dart';
import 'package:momentry/repositories/movie_repository.dart';

final movieListProvider = StateNotifierProvider((ref) {
  final repository = MovieRepository();
  return MovieListStateNotifier(repository: repository);
});

class MovieListStateNotifier
    extends StateNotifier<AsyncValue<List<MovieDetail>>> {
  final MovieRepository repository;

  MovieListStateNotifier({required this.repository})
      : super(const AsyncValue.loading());

  Future<void> findAll() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => repository.fetchList());
  }

  Future<void> add(Map<String, dynamic> post) async {
    await repository.add(post);
    findAll();
  }

  Future<void> update(Map<String, dynamic> movieAddRequest, int id) async {
    await repository.update(movieAddRequest, id);
    findAll();
  }

  Future<void> delete(int id) async {
    await repository.delete(id);
    findAll();
  }
}
