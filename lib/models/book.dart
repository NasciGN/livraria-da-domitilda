class Books {
  final String id;
  final String selfLink;
  final String title;
  final List authors;
  final String publisher;
  final String publishedDate;
  final String description;
  final String pageCount;
  final String type;
  final List categories;
  final String thumb;
  final String language;
  final String link;

  Books({
    required this.id,
    required this.selfLink,
    required this.title,
    required this.authors,
    required this.publisher,
    required this.publishedDate,
    required this.description,
    required this.pageCount,
    required this.type,
    required this.categories,
    required this.thumb,
    required this.language,
    required this.link,
  });
}
