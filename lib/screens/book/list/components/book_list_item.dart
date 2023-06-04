import 'package:flutter/material.dart';
import 'package:momentry/models/book/book_detail.dart';

class BookListItem extends StatelessWidget {
  final BookDetail item;
  final VoidCallback? onTap;

  const BookListItem({Key? key, this.onTap, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  border: Border.all(color: Colors.grey.withOpacity(0.3)),
                ),
                child: AspectRatio(
                  aspectRatio: 3 / 4,
                  child: Image.network(
                    item.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                item.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              Text('★${item.star}'),
            ],
          ),
        ),
      ),
    );
  }
}
