class BlogAjax {
  int id;
  String title;
  String content;
  DateTime publishedAt;
  bool isLikedByMe = false;

  BlogAjax({
    this.id = 0,
    required this.title,
    required this.content,
    required this.publishedAt,
    required bool isLikedByMe,
  });

  String get publishedDateString =>
      "${publishedAt.day}.${publishedAt.month}.${publishedAt.year}";

  factory BlogAjax.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'id': int id,
      'title': String title,
      'content:': String content,
      'publishedAt': DateTime publishedAt,
      'isLikedByMe': bool isLikedByMe
      } =>
          BlogAjax(
              id: id,
              title: title,
              content: content,
              publishedAt: publishedAt,
              isLikedByMe: isLikedByMe),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}