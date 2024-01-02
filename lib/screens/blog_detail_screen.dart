// blog_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:in307blog/models/blog.dart';

class BlogDetailScreen extends StatelessWidget {
  final Blog blog;

  BlogDetailScreen({required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(blog.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(blog.imageUrl),
            SizedBox(height: 16),
            Text(
              blog.description,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
