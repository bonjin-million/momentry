import 'package:flutter/material.dart';

class BookListBody extends StatelessWidget {
  const BookListBody({Key? key}) : super(key: key);

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
              width: MediaQuery.of(context).size.width / 4,
            ),
            const SizedBox(height: 24,),
            const Text('등록된 책이 없어요'),
          ],
        ),
      ),
    );
  }
}
