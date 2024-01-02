class Blog {
  String title;

  String content;

  DateTime publishedAt;

  // Konstruktor
  Blog({
    required this.title,
    required this.content,
    required this.publishedAt,
  });

  String get publishedDateString =>
      "${publishedAt.day}.${publishedAt.month}.${publishedAt.year}";
}
