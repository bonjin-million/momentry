import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:momentry/models/post/post_add_request.dart';
import 'package:momentry/providers/post_provider.dart';

class PostAddBody extends ConsumerWidget {
  const PostAddBody({Key? key}) : super(key: key);

  void add(WidgetRef ref) async {
    final newPost = PostAddRequest(title: 'title', content: 'content');
    await ref.read(postProvider.notifier).add(newPost.toMap());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
      child: Column(
        children: [
          SizedBox(
            child: Text(
              '2023.05.23',
              style: TextStyle(fontSize: 17),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextField(
                autofocus: true,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: '일기 작성하는 곳',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () {
                    add(ref);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
