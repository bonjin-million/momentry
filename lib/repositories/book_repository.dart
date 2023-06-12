import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:momentry/database/book_database.dart';
import 'package:momentry/models/book/book_detail.dart';
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
    return BookResponse.fromJson(jsonDecode(response.body));
  }

  Future<List<BookDetail>> fetchList() async {
    final response = await BookDatabase().findAll();
    return response;
  }

  Future<BookDetail> fetchDetailItem(int id) async {
    final response = await BookDatabase().findById(id);
    return response;
  }

  Future<void> add(Map<String, dynamic> bookAddRequest) async {
    await BookDatabase().insert(bookAddRequest);
  }

  Future<void> update(Map<String, dynamic> bookAddRequest, int id) async {
    await BookDatabase().update(bookAddRequest, id);
  }

  Future<void> delete(int id) async {
    await BookDatabase().delete(id);
  }
}
