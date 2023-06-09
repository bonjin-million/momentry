import 'package:flutter/material.dart';
import 'package:momentry/models/movie/movie.dart';
import 'package:momentry/widgets/custom_image.dart';

class MovieSearchItem extends StatelessWidget {
  final Movie item;
  final GestureTapCallback? onTap;

  const MovieSearchItem({Key? key, required this.item, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              border: Border.all(
                  color: Colors.grey.withOpacity(0.3)
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              child: AspectRatio(
                aspectRatio: 3 / 4,
                child: CustomImage(
                  imageUrl: item.posters.firstOrNull?.imageUrl ?? '',
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
          Text(
            item.prodYear,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
