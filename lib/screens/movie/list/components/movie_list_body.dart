import 'package:flutter/material.dart';

class MovieListBody extends StatelessWidget {
  const MovieListBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/panic.png',
              width: MediaQuery.of(context).size.width * 0.2,
            ),
            const SizedBox(height: 24,),
            const Text('등록된 영화가 없어요'),
          ],
        ),
      ),
    );
  }
}
