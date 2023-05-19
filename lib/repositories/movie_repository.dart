import 'package:http/http.dart' as http;
import 'dart:core';

class MovieRepository {

  Future<void> fetchItems() async {
    final uri = Uri.parse('https://openapi.naver.com/v1/search/movie.json?query=%EC%A3%BC%EC%8B%9D&display=10&start=1&genre=1');

    // HTTP 요청 헤더에 액세스 키 포함
    final Map<String, String> headers = {
      'X-Naver-Client-Id': "Fx_9vRMDzKenwd0PZ9rR",
      'X-Naver-Client-Secret': "u4zq7X3jv2",
    };

    final response = await http.get(uri, headers: headers);

    print(response.body);
  }
}