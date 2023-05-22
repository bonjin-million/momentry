import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:momentry/models/post.dart';
import 'package:momentry/repositories/post_repository.dart';

class PostStateNotifier extends StateNotifier<AsyncValue<Post>> {
  final PostRepository repository;

  PostStateNotifier({
    required this.repository,
  }) : super(const AsyncValue.loading());

  Future<void> findAll() async {

  }
}
