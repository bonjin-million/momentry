import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:momentry/models/post/post.dart';
import 'package:momentry/repositories/post_repository.dart';

final postDetailProvider = StateNotifierProvider.autoDispose.family<PostDetailStateNotifier, AsyncValue<Post>, int>((ref, id) {
  final repository = PostRepository();
  return PostDetailStateNotifier(id: id, repository: repository);
});

class PostDetailStateNotifier extends StateNotifier<AsyncValue<Post>> {
  final int id;
  final PostRepository repository;

  PostDetailStateNotifier({
    required this.id,
    required this.repository,
  }) : super(const AsyncValue.loading());

  Future<void> fetch() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => repository.fetchItem(id));
  }
}