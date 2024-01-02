import 'dart:convert';
import 'package:http/http.dart' as http;

class BlogServiceAjax {
  static const String baseUrl = 'https://cloud.appwrite.io/v1/databases/blog-db/collections/blogs/documents';
  static const String projectID = '6568509f75ac404ff6ae';
  static const String appKey = 'ac0f362d0cf82fe3d138195e142c0a87a88cee4e2c48821192fb307e1a1c74ee694246f90082b4441aa98a2edaddead28ed6d18cf08c4de0df90dcaeeb53d14f14fb9eeb2edec6708c9553434f1d8df8f8acbfbefd35cccb70f2ab0f9a334dfd979b6052f6e8b8610d57465cbe8d71a7f65e8d48aede789eef6b976b1fe9b2e2';
  static const String $id = '657f28cfd9b49126b5b1';
  
  static Future<http.Response> fetchBlogs() {
    final url = Uri.parse(baseUrl);
    final headers = {
      'X-Appwrite-Project': projectID,
      'X-Appwrite-Key': appKey,
    };
    return http.get(url, headers: headers);
  }
  static Future<http.Response> createBlog({required String title, required String content}) async {
    final url = Uri.parse(baseUrl);
    final headers = {
      'X-Appwrite-Project': projectID,
      'X-Appwrite-Key': appKey,
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> blogData = {
      'data': {
        'title': title,
        'content': content,
        'headerImageUrl': null,
        'comments': [],
        'userIdsWithLikes': [],
        'id': $id
      },
    };
    final String requestBody = json.encode(blogData);
    return http.post(url, headers: headers, body: requestBody);
  }
}