import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:in307blog/presentation/models/blog.dart';

class BlogRepository {
  final String baseUrl = 'http://localhost:3000';

  Future<List<Blog>> getAllBlogs() async {
    final response = await http.get(Uri.parse('$baseUrl/blog'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Blog(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        image: json['image'],
      )).toList();
    } else {
      throw Exception('Failed to load blogs');
    }
  }
}