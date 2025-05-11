import 'package:api_integration/post.dart';
import 'package:dio/dio.dart';


class DioService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'));

  Future<List<Post>> fetchPosts() async {
    try {
      final response = await _dio.get('/posts');
      final List data = response.data;
      return data.map((json) => Post.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch posts: $e');
    }
  }
}