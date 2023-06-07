import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:momentry/models/post/post.dart';
import 'package:momentry/repositories/post_repository.dart';

final postProvider = StateNotifierProvider((ref) {
  final repository = PostRepository();
  return PostStateNotifier(repository: repository);
});

class PostStateNotifier extends StateNotifier<AsyncValue<List<Post>>> {
  final PostRepository repository;

  PostStateNotifier({
    required this.repository,
  }) : super(const AsyncValue.loading());

  Future<void> findAll() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => repository.fetchItems());
  }

  Future<void> add(Map<String, dynamic> post) async {
    await repository.add(post);
    findAll();
  }

  Future<void> delete(int id) async {
    await repository.delete(id);
    findAll();
  }
}
