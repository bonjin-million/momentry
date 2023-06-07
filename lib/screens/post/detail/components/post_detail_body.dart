import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:momentry/models/post/post.dart';
import 'package:momentry/providers/post/post_detail_provider.dart';

class PostDetailBody extends ConsumerStatefulWidget {
  final int id;

  const PostDetailBody({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  ConsumerState<PostDetailBody> createState() => _PostDetailBodyState();
}

class _PostDetailBodyState extends ConsumerState<PostDetailBody> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(postDetailProvider(widget.id).notifier).fetch();
    });
  }

  @override
  Widget build(BuildContext context) {

    final state = ref.watch(postDetailProvider(widget.id));

    final isData = state is AsyncData<Post>;
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

    final item = state.value;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.date),
          Visibility(
            visible: item.imageFile.isNotEmpty,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.memory(base64Decode(item.imageFile)),
                  ),
                ],
              ),
            ),
          ),
          Text(item.content),
        ],
      ),
    );
  }
}
