import 'package:flutter/material.dart';
import 'package:theming_navigation/models/blog.dart';

class BlogDetailPage extends StatelessWidget {
  final Blog blog;
  const BlogDetailPage({required this.blog, super.key});

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
          children: <Widget>[
            Text(blog.title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8.0),
            Text(blog.content),
            const SizedBox(height: 8.0),
            Text(blog.publishedDateString,
                style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
