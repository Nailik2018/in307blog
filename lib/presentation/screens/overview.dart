import 'package:flutter/material.dart';
import 'package:in307blog/presentation/models/blog.dart';
import 'package:in307blog/presentation/services/blog_service.dart';

class BlogListPage extends StatefulWidget {
  @override
  _BlogListPageState createState() => _BlogListPageState();
}

class _BlogListPageState extends State<BlogListPage> {
  final BlogService _blogService = BlogService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog List'),
      ),
      body: FutureBuilder<List<Blog>>(
        future: _blogService.getAllBlogs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final blogs = snapshot.data!;
            return ListView.builder(
              itemCount: blogs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(blogs[index].title),
                  subtitle: Text(blogs[index].description),
                );
              },
            );
          }
        },
      ),
    );
  }
}