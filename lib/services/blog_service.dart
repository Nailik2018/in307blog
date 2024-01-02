// services/blog_service.dart
import 'package:in307blog/models/blog.dart';

class BlogService {

  List<Blog> _blogs = [
    Blog(
      title: 'Blog 1',
      description: 'Beschreibung für Blog 1.',
      imageUrl: 'https://placekitten.com/200/300',
    ),
    Blog(
      title: 'Blog 2',
      description: 'Beschreibung für Blog 2.',
      imageUrl: 'https://placekitten.com/200/301',
    ),
  ];

  Future<List<Blog>> getAllBlogs() async {
    await Future.delayed(Duration(seconds: 1));
    return _blogs;
  }

  Future<void> addBlog(Blog blog) async {
    _blogs.add(blog);
  }

  void updateBlog(int index, Blog blog) {
    _blogs[index] = blog;
  }

  void deleteBlog(int index) {
    _blogs.removeAt(index);
  }
}