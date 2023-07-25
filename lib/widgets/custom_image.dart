import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String imageUrl;
  const CustomImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return Center(
        child: Image.asset('assets/images/no-image.png'),
      );
    }

    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return const Center(
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child: CircularProgressIndicator(),
          ),
        );
      },
      errorBuilder:
          (BuildContext context, Object error, StackTrace? stackTrace) {
        return Image.asset('assets/images/no-image.png');
      },
    );
  }
}
