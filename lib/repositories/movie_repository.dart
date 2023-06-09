import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:momentry/database/movie_database.dart';
import 'package:momentry/models/movie/movie_detail.dart';
import 'dart:core';

import 'package:momentry/models/movie/movie_response.dart';

class MovieRepository {
  final apiKey = "Z8FMIU652ZR9ZAEVQDO3";

  Future<MovieResponse> fetchItems({required String keyword}) async {
    final uri = Uri.parse('http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&detail=Y&listCount=50&ServiceKey=$apiKey&title=$keyword');
    final response = await http.get(uri);
    return MovieResponse.fromJson(jsonDecode(response.body));
  }

  Future<List<MovieDetail>> fetchList() async {
    final response = await MovieDatabase().findAll();
    return response;
  }

  Future<MovieDetail> fetchDetailItem(int id) async {
    final response = await MovieDatabase().findById(id);
    return response;
  }

  Future<void> add(Map<String, dynamic> data) async {
    await MovieDatabase().insert(data);
  }
}