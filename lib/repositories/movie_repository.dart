import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:core';

import 'package:momentry/models/movie/movie_response.dart';

class MovieRepository {
  final apiKey = "Z8FMIU652ZR9ZAEVQDO3";

  Future<MovieResponse> fetchItems({required String keyword}) async {
    final uri = Uri.parse('http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&detail=N&listCount=50&ServiceKey=$apiKey&title=$keyword');

    final response = await http.get(uri);

    print(response.body);

    return MovieResponse.fromJson(jsonDecode(response.body));
  }
}