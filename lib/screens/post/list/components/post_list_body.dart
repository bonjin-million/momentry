import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:momentry/models/post/post.dart';
import 'package:momentry/providers/post_provider.dart';
import 'package:momentry/screens/post/detail/post_detail_screen.dart';
import 'package:momentry/screens/post/list/components/post_list_item.dart';

class PostListBody extends ConsumerStatefulWidget {
  const PostListBody({Key? key}) : super(key: key);

  @override
  ConsumerState<PostListBody> createState() => _PostListBodyState();
}

class _PostListBodyState extends ConsumerState<PostListBody> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(postProvider.notifier).findAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(postProvider);

    final isData = state is AsyncData<List<Post>>;
    final isLoading = state is AsyncLoading;
    final isError = state is AsyncError;

    if (isLoading || !isData) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (isError) {
      return const Center(
        child: Text('오류!'),
      );
    }

    final items = state.value;
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return PostListItem(
          item: item,
          leading: Text('ID: ${item.id}'),
          trailing: IconButton(
            onPressed: () {
              ref.read(postProvider.notifier).delete(item.id);
            },
            icon: const Icon(Icons.delete),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PostDetailScreen(),
              ),
            );
          },
        );
      },
    );
  }
}
