import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:core';

import 'package:momentry/models/book/book_response.dart';

class BookRepository {
  Future<BookResponse> fetchItems({
    required String keyword,
  }) async {
    final uri = Uri.parse(
        'https://openapi.naver.com/v1/search/book.json?query=$keyword&display=10&start=1');

    // HTTP 요청 헤더에 액세스 키 포함
    final Map<String, String> headers = {
      'X-Naver-Client-Id': "Fx_9vRMDzKenwd0PZ9rR",
      'X-Naver-Client-Secret': "u4zq7X3jv2",
    };

    final response = await http.get(uri, headers: headers);
    print(response.body);
    return BookResponse.fromJson(jsonDecode(response.body));
  }
}
