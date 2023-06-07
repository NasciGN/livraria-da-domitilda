import 'dart:convert';
import 'package:livraria_da_domitilda/models/book.dart';
import 'package:http/http.dart' as http;

String url = 'https://www.googleapis.com/books/v1/volumes?q=';
String keyPart = '&maxResults=40&:keyes&key=';
String keyApi = 'AIzaSyD6joyGa7KCGsGl1uUWcqJi20M6uRnQBq0';

Future<List<Books>> fetchSearchBooks(String search) async {
  final http.Response response =
      await http.get(Uri.parse('$url$search$keyPart$keyApi'));

  List<Books> searchResult = [];

  if (response.statusCode == 200) {
    var jsonBook = jsonDecode(response.body);
    for (var book in jsonBook["items"]) {
      Books actualBook = jsonBookDecode(book);
      searchResult.add(actualBook);
      //print('Book added: ${searchResult}');
    }
  }
  print("Debug Google Docs List: $searchResult");
  return searchResult;
}

Books jsonBookDecode(final jsonBook) {
  List authors = [];
  if (jsonBook["volumeInfo"]["authors"] != null) {
    for (var author in jsonBook["volumeInfo"]["authors"]) {
      authors.add(author);
    }
  }
  List categories = [];
  if (jsonBook["volumeInfo"]["categories"] != null) {
    for (var categorie in jsonBook["volumeInfo"]["categories"]) {
      categories.add(categorie);
    }
  }

  return Books(
    id: jsonBook["id"],
    selfLink: jsonBook["selfLink"] ?? '',
    title: jsonBook["volumeInfo"]["title"] ?? '',
    authors: authors,
    publisher: jsonBook["volumeInfo"]["publisher"] ?? '',
    publishedDate: jsonBook["volumeInfo"]["publishedDate"] ?? '',
    description: jsonBook["volumeInfo"]["description"] ?? '',
    pageCount: jsonBook["volumeInfo"]["pageCount"]?.toString() ?? '',
    type: jsonBook["volumeInfo"]["type"] ?? '',
    categories: categories,
    thumb: jsonBook["volumeInfo"]["imageLinks"]?["thumbnail"] ?? '',
    language: jsonBook["volumeInfo"]["language"] ?? '',
    link: jsonBook["volumeInfo"]["canonicalVolumeLink"] ?? '',
  );
}
