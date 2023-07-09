import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:momentry/database/movie_database.dart';
import 'package:momentry/models/movie/movie_detail.dart';
import 'dart:core';

import 'package:momentry/models/movie/movie_response.dart';

class MovieRepository {
  // final apiKey = "Z8FMIU652ZR9ZAEVQDO3";

  final apiKey = "748a988dd7391c38f054a669ae678d1b";
  Future<MovieResponse> fetchItems({required String keyword}) async {
    // final uri = Uri.parse(
    //     'http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&detail=Y&listCount=50&ServiceKey=$apiKey&title=$keyword');
    final uri = Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$keyword&language=ko-KR');

    // 'https://api.themoviedb.org/3/search/movie?api_key=748a988dd7391c38f054a669ae678d1b&page=1&query=%EB%B2%94%EC%A3%84&language=ko-KR');

    final response = await http.get(uri);

    print("@@@@@@@ ${MovieResponse.fromJson(jsonDecode(response.body))}");

    return MovieResponse.fromJson(jsonDecode(response.body));
  }

  Future<List<MovieDetail>> fetchList() async {
    final response = await MovieDatabase().findAll();
    return response;
  }

  Future<MovieDetail> fetchDetailItem(int id) async {
    // final response = await MovieDatabase().findById(id);
    // return response;

    final uri = Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$id&language=ko-KR');

    final response = await http.get(uri);

    print("@@@@@@@ ${MovieDetail.fromJson(jsonDecode(response.body))}");

    return MovieDetail.fromJson(jsonDecode(response.body));
  }

  Future<void> add(Map<String, dynamic> data) async {
    await MovieDatabase().insert(data);
  }

  Future<void> delete(int id) async {
    await MovieDatabase().delete(id);
  }
}
