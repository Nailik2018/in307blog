import 'package:flutter/material.dart';
import 'package:in307blog/unterricht/unterricht2023theming_navigation/models/blog.dart';
import 'package:in307blog/unterricht/unterricht2023theming_navigation/screens/blog/blog_detail_page.dart';
import 'package:in307blog/unterricht/unterricht2023theming_navigation/services/blog_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BlogRepository _blogRepository = BlogRepository();

  List<Blog>? blogs;

  @override
  void initState() {
    super.initState();

    // Blog-Einträge asynchron abrufen
    _blogRepository.getBlogPosts().then((blogPosts) {
      if (!mounted) {
        return;
      }
      setState(() {
        blogs = blogPosts;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (blogs == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (blogs!.isEmpty) {
      return const Center(
        child: Text('No blogs yet.'),
      );
    }
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text("Blog"),
        backgroundColor: Colors.transparent,
      ),
      body: ListView.builder(
        itemCount: blogs!.length,
        itemBuilder: (context, index) {
          var blog = blogs![index];
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: BlogWidget(blog: blog),
          );
        },
      ),
    );
  }
}

class BlogWidget extends StatelessWidget {
  const BlogWidget({super.key, required this.blog});

  final Blog blog;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => BlogDetailPage(blog: blog),
          ));
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(blog.content),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(blog.publishedDateString,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontStyle: FontStyle.italic,
                            )),
                    IconButton(
                      icon: const Icon(
                        Icons.favorite_border,
                      ),
                      onPressed: () {
                        // TODO: Like Blog
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
