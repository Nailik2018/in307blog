import 'package:flutter/material.dart';
import 'package:in307blog/services/blog_service_ajax.dart';
import 'dart:convert'; // Import this for JSON decoding

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Blog Fetcher'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _fetchBlogs();
                },
                child: Text('Fetch Blogs'),
              ),
              SizedBox(height: 16.0), // Abstand zwischen den Buttons
              ElevatedButton(
                onPressed: () {
                  _createBlog();
                },
                child: Text('Create Blog'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _fetchBlogs() async {
    final response = await BlogServiceAjax.fetchBlogs();
    final jsonList = json.decode(response.body)['documents'] as List<dynamic>;
    print('_fetchBlogs');
    if (response.statusCode == 200) {
      for(var blog in jsonList) {
        print("##############################################################");
        print(blog);
        // print(blog['title']);
        // print(blog['content']);
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  void _createBlog() async {
    try {
      final blogState = await BlogServiceAjax.createBlog(title: 'Flutter :-(', content: 'Flutter ist doof');
      print(blogState);
      print(blogState.statusCode);
      Auto auto = Auto('BMW');
      // auto.addValue(1);
      // auto.addValue(2);
      print(auto.getBranch());
      print('Blog erfolgreich erstellt.');
    } catch (e) {
      print('Fehler beim Erstellen des Blogs: $e');
    }
  }
}

class Auto {
  late final String branch;

  Auto(this.branch);

  String getBranch() {
    return this.branch;
  }

  void setBranch(String branch) {
    this.branch = branch;
  }
}
