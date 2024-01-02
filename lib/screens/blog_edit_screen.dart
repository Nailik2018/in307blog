// blog_edit_screen.dart
import 'package:flutter/material.dart';
import 'package:in307blog/models/blog.dart';

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
    _descriptionController = TextEditingController(text: widget.blog?.description ?? '');
    _imageUrlController = TextEditingController(text: widget.blog?.imageUrl ?? '');
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
