import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Blog {
  final String title;
  final String description;
  final String imageUrl;

  Blog({required this.title, required this.description, required this.imageUrl});
}

class MyApp extends StatelessWidget {
  final List<Blog> blogs = [
    Blog(
      title: 'Blog 1',
      description: 'Beschreibung für Blog 1.',
      imageUrl: 'https://placekitten.com/200/300', // Beispielbild-URL
    ),
    Blog(
      title: 'Blog 2',
      description: 'Beschreibung für Blog 2.',
      imageUrl: 'https://placekitten.com/200/301', // Beispielbild-URL
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlogListScreen(blogs: blogs),
    );
  }
}

class BlogListScreen extends StatefulWidget {
  final List<Blog> blogs;

  BlogListScreen({required this.blogs});

  @override
  _BlogListScreenState createState() => _BlogListScreenState();
}

class _BlogListScreenState extends State<BlogListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Liste'),
      ),
      body: ListView.builder(
        itemCount: widget.blogs.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(widget.blogs[index].title),
            onDismissed: (direction) {
              _deleteBlog(index);
            },
            background: Container(
              color: Colors.red,
              child: Icon(Icons.delete, color: Colors.white),
            ),
            child: ListTile(
              title: Text(widget.blogs[index].title),
              subtitle: Text(widget.blogs[index].description),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(widget.blogs[index].imageUrl),
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
      setState(() {
        widget.blogs.add(result);
      });
    }
  }

  void _editBlog(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlogEditScreen(
          blog: widget.blogs[index],
        ),
      ),
    );

    if (result != null && result is Blog) {
      setState(() {
        widget.blogs[index] = result;
      });
    }
  }

  void _deleteBlog(int index) {
    setState(() {
      widget.blogs.removeAt(index);
    });
  }
}

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

class BlogEditScreen extends StatefulWidget {
  final Blog? blog;

  BlogEditScreen({this.blog});

  @override
  _BlogEditScreenState createState() => _BlogEditScreenState();
}

class _BlogEditScreenState extends State<BlogEditScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageUrlController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.blog?.title ?? '');
    _descriptionController =
        TextEditingController(text: widget.blog?.description ?? '');
    _imageUrlController =
        TextEditingController(text: widget.blog?.imageUrl ?? '');
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
              controller: _imageUrlController,
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

  void _saveBlog() {
    final title = _titleController.text;
    final description = _descriptionController.text;
    final imageUrl = _imageUrlController.text;

    if (title.isNotEmpty && description.isNotEmpty && imageUrl.isNotEmpty) {
      Navigator.pop(
        context,
        Blog(title: title, description: description, imageUrl: imageUrl),
      );
    }
  }
}
