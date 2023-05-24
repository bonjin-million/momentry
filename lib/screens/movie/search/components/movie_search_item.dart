import 'package:flutter/material.dart';
import 'package:momentry/models/movie/movie.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parse;
import 'package:http/http.dart' as http;
import 'package:momentry/widgets/custom_image.dart';

class MovieSearchItem extends StatefulWidget {
  final Movie item;

  const MovieSearchItem({Key? key, required this.item}) : super(key: key);

  @override
  State<MovieSearchItem> createState() => _MovieSearchItemState();
}

class _MovieSearchItemState extends State<MovieSearchItem> {
  String imageUrl = "";

  Future<void> fetchImageUrl() async {
    final response = await http.get(Uri.parse(widget.item.detailUrl));
    dom.Document document = parse.parse(response.body);
    final style = document.body?.querySelector(".mProfile > .mImg1 > span")?.attributes["style"];
    if(style != null) {
      final imageUrl = textToUrl(style);
      if(imageUrl.isNotEmpty) {
        if(mounted) {
          setState(() {
            this.imageUrl = imageUrl;
          });
        }
      }
    }
  }

  String textToUrl(String value) {
    RegExp regExp = RegExp(r'((([A-Za-z]{3,9}:(?:\/\/)?)(?:[-;:&=\+\$,\w]+@)?[A-Za-z0-9.-]+|(?:www.|[-;:&=\+\$,\w]+@)[A-Za-z0-9.-]+)((?:\/[\+~%\/.\w-_]*)?\??(?:[-\+=&;%@.\w_]*)#?(?:[\w]*))?)');
    final urlMatches = regExp.allMatches(value);
    final urls = urlMatches.map((m) => value.substring(m.start, m.end)).toList();
    return urls.firstWhere((e) => e != '', orElse: () => '');
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchImageUrl();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                imageUrl: imageUrl,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          widget.item.title,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
        Text(
          widget.item.prodYear,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
