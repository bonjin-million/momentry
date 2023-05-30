import 'package:flutter/material.dart';
import 'package:momentry/models/post/post.dart';

class PostListItem extends StatelessWidget {
  final Post item;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  const PostListItem(
      {Key? key, required this.item, this.onTap, this.leading, this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Card(
      child: ListTile(
        leading: leading,
        title: Text(item.date),
        subtitle: Text(item.content),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
