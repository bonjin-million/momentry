import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:momentry/models/movie/movie_detail.dart';

class MovieListItem extends StatelessWidget {
  final MovieDetail item;
  final VoidCallback? onTap;

  const MovieListItem({Key? key, this.onTap, required this.item})
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
                  child: item.type == 'FILE'
                      ? Image.memory(
                          base64Decode(
                            item.image,
                          ),
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          item.image,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Text(
                item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: item.stars.asMap().entries.map(
                    (e) {
                      bool value = e.value;

                      return Icon(
                        value ? Icons.star : Icons.star_border_outlined,
                        color: value ? Colors.amber : Colors.grey,
                        size: 15,
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
