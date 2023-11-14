import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class BlogPost {
  final String title;
  final String imageUrl;
  final String description;

  BlogPost({
    required this.title,
    required this.imageUrl,
    required this.description,
  });
}

class BlogPostCard extends StatelessWidget {
  final BlogPost blogPost;

  BlogPostCard({required this.blogPost});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            blogPost.imageUrl,
            height: 100,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blogPost.title,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(blogPost.description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BlogGrid extends StatelessWidget {
  final List<BlogPost> blogPosts;

  BlogGrid({required this.blogPosts});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: blogPosts.length,
      itemBuilder: (context, index) {
        return BlogPostCard(blogPost: blogPosts[index]);
      },
    );
  }
}

class MyApp extends StatelessWidget {
  final List<BlogPost> blogPosts = [
    BlogPost(
      title: 'Blog Post 1',
      imageUrl: 'https://ki-lian.ch/ki-lian-tiny.c7c1a38a015ecbea.jpg',
      description: 'Beschreibung 1.',
    ),
    BlogPost(
      title: 'Blog Post 2',
      imageUrl: 'https://ki-lian.ch/ki-lian-tiny.c7c1a38a015ecbea.jpg',
      description: 'Beschreibung 2.',
    ),
  ];

  BlogPost generateRandomBlogPost() {
    int randomNumber = Random().nextInt(1000);
    return BlogPost(
      title: 'Generierter Blog Post $randomNumber',
      imageUrl: 'https://ki-lian.ch/ki-lian-tiny.c7c1a38a015ecbea.jpg',
      description: 'Beschreibung $randomNumber.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Blog App'),
        ),
        body: BlogGrid(blogPosts: blogPosts),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            BlogPost newBlogPost = generateRandomBlogPost();
            blogPosts.add(newBlogPost);
            (context as Element).markNeedsBuild();
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
