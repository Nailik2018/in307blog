// screens/blog_list_screen.dart
import 'package:flutter/material.dart';
import 'package:in307blog/models/blog.dart';
import 'package:in307blog/services/blog_service.dart';
// import 'blog_detail_screen.dart';
import 'blog_edit_screen.dart';

class BlogListScreen extends StatefulWidget {
  @override
  _BlogListScreenState createState() => _BlogListScreenState();
}

class _BlogListScreenState extends State<BlogListScreen> {
  late Future<List<Blog>> _blogsFuture;
  final BlogService _blogService = BlogService();

  @override
  void initState() {
    super.initState();
    _blogsFuture = _blogService.getAllBlogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Liste'),
      ),
      body: FutureBuilder<List<Blog>>(
        future: _blogsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Fehler beim Laden der Daten.');
          } else {
            List<Blog>? blogs = snapshot.data;
            return ListView.builder(
              itemCount: blogs?.length ?? 0,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(blogs![index].title),
                  onDismissed: (direction) {
                    _deleteBlog(index);
                  },
                  background: Container(
                    color: Colors.red,
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ListTile(
                    title: Text(blogs[index].title),
                    subtitle: Text(blogs[index].description),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(blogs[index].imageUrl),
                    ),
                    onTap: () {
                      _editBlog(index);
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToBlogEditScreen(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _navigateToBlogEditScreen(BuildContext context) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlogEditScreen(),
      ),
    );

    if (result != null && result is Blog) {
      setState(() async {
        await _blogService.addBlog(result);
        _blogsFuture = _blogService.getAllBlogs();
      });
    }
  }

  void _deleteBlog(int index) {
    setState(() {
      _blogService.deleteBlog(index);
      _blogsFuture = _blogService.getAllBlogs();
    });
  }

  void _editBlog(int index) async {
    List<Blog> blogs = await _blogsFuture;

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlogEditScreen(blog: blogs[index]),
      ),
    );

    if (result != null && result is Blog) {
      setState(() {
        _blogService.updateBlog(index, result);
        _blogsFuture = _blogService.getAllBlogs();
      });
    }
  }
}
