import 'package:flutter/material.dart';
import 'package:in307blog/presentation/screens/overview.dart';

// void main() {
//   runApp(BlogApp());
// }
//
// class BlogApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Blog-App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: BlogListPage(),
//     );
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;

class Blog {
  final int id;
  final String title;
  final String description;
  final String image;

  Blog({required this.id, required this.title, required this.description, required this.image});
}

class BlogService {
  final String baseUrl = 'http://192.168.0.12:3000/blog';

  Future<List<Blog>> getAllBlogs() async {
    final response = await http.get(Uri.parse(baseUrl));
    print("getAllBlogs");
    print(response.statusCode);
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

  Future<Blog> getBlogById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Blog(
        id: data['id'],
        title: data['title'],
        description: data['description'],
        image: data['image'],
      );
    } else {
      throw Exception('Failed to load blog');
    }
  }

  Future<void> createBlog(Blog blog) async {
    await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': blog.title,
        'description': blog.description,
        'image': blog.image,
      }),
    );
  }

  // Future<void> updateBlog(int id, Blog blog) async {
  //   await http.put(
  //     Uri.parse('$baseUrl/$id'),
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode({
  //       'title': blog.title,
  //       'description': blog.description,
  //       'image': blog.image,
  //     }),
  //   );
  // }

  Future<void> updateBlog(int id, Blog blog) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'title': blog.title,
          'description': blog.description,
          'image': blog.image,
        }),
      );

      if (response.statusCode == 200) {
        print('Blog updated successfully');
      } else {
        print('Failed to update blog. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error updating blog: $e');
    }
  }

  Future<void> deleteBlog(int id) async {
    await http.delete(Uri.parse('$baseUrl/$id'));
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlogListScreen(),
    );
  }
}

class BlogListScreen extends StatefulWidget {
  @override
  _BlogListScreenState createState() => _BlogListScreenState();
}

class _BlogListScreenState extends State<BlogListScreen> {
  final BlogService _blogService = BlogService();
  late List<Blog> blogs;

  @override
  void initState() {
    super.initState();
    blogs = [];
    _loadBlogs();
  }

  Future<void> _loadBlogs() async {
    print("_loadBlogs");
    try {
      final loadedBlogs = await _blogService.getAllBlogs();
      setState(() {
        blogs = loadedBlogs;
      });
    } catch (e) {
      print('Error loading blogs: $e');
      // Show a Snackbar or Dialog with the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading blogs. Please check your network connection.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Liste'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _loadBlogs(); // Reload blogs when the refresh button is pressed
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: blogs.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(blogs[index].id.toString()),
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
                backgroundImage: NetworkImage(blogs[index].image),
              ),
              onTap: () {
                _editBlog(index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addBlog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _addBlog() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlogEditScreen(),
      ),
    );

    if (result != null && result is Blog) {
      await _blogService.createBlog(result);
      _loadBlogs();
    }
  }

  void _editBlog(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlogEditScreen(
          blog: blogs[index],
        ),
      ),
    );

    if (result != null && result is Blog) {
      await _blogService.updateBlog(blogs[index].id, result);
      _loadBlogs();
    }
  }

  void _deleteBlog(int index) async {
    await _blogService.deleteBlog(blogs[index].id);
    _loadBlogs();
  }
}

class BlogEditScreen extends StatefulWidget {
  final Blog? blog;

  BlogEditScreen({this.blog});

  @override
  _BlogEditScreenState createState() => _BlogEditScreenState();
}

class _BlogEditScreenState extends State<BlogEditScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.blog?.title ?? '');
    _descriptionController =
        TextEditingController(text: widget.blog?.description ?? '');
    _imageController =
        TextEditingController(text: widget.blog?.image ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.blog == null ? 'Neuen Blog erstellen' : 'Blog bearbeiten'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Titel'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Beschreibung'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _imageController,
              decoration: InputDecoration(labelText: 'Bild-URL'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _saveBlog();
              },
              child: Text('Speichern'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveBlog() async {
    final title = _titleController.text;
    final description = _descriptionController.text;
    final image = _imageController.text;

    if (title.isNotEmpty && description.isNotEmpty && image.isNotEmpty) {
      Navigator.pop(
        context,
        Blog(id: widget.blog?.id ?? 0, title: title, description: description, image: image),
      );
    }
  }
}