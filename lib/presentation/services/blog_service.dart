import 'package:in307blog/presentation/models/blog.dart';
import 'package:in307blog/presentation/repository/blog_repository.dart';

class BlogService {
  final BlogRepository _repository = BlogRepository();

  Future<List<Blog>> getAllBlogs() {
    return _repository.getAllBlogs();
  }
}