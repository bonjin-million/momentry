import 'package:flutter/material.dart';
import 'package:momentry/models/book/book.dart';
import 'package:momentry/screens/book/add/book_add_screen.dart';

class BookSearchItem extends StatelessWidget {
  final Book item;

  const BookSearchItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookAddScreen(book: (item)),
            fullscreenDialog: true,
          ),
        )
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              border: Border.all(color: Colors.grey.withOpacity(0.3)),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              child: AspectRatio(
                aspectRatio: 3 / 4,
                child: Image.network(
                  item.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            item.title,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          Visibility(
            visible: item.author.isNotEmpty,
            child: Text(
              item.author,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
