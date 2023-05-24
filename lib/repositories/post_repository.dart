import 'package:momentry/database/post_database.dart';
import 'package:momentry/models/post/post.dart';

class PostRepository {
  Future<List<Post>> fetchItems() async {
    final response = await PostDatabase().findAll();
    return response;
  }

  Future<void> add(Map<String, dynamic> post) async {
    await PostDatabase().insert(post);
  }

  Future<void> delete(int id) async {
    await PostDatabase().delete(id);
  }
}