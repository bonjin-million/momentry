import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:momentry/models/post/post.dart';

class PostListItem extends StatelessWidget {
  final Post item;
  final VoidCallback? onTap;

  const PostListItem({Key? key, required this.item, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  item.date,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Visibility(
                visible: item.imageFile.isNotEmpty,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(
                    base64Decode(item.imageFile),
                  ),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                item.content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
