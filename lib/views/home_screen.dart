import 'package:flutter/material.dart';
import 'package:livraria_da_domitilda/models/book.dart';
import 'package:livraria_da_domitilda/modelviews/google_books.dart';
import 'package:livraria_da_domitilda/views/components/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<Books> books = [];
bool isLoading = false;

Future<List<Books>> fetchBooks(String search) async {
  books = await fetchSearchBooks(search);
  isLoading = !isLoading;
  return books;
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: defaultpd * 2, vertical: defaultpd * 3),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'Home',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            decoration: InputDecoration(
                labelText: 'Search for a Book, Author, Gender...',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: bgColor),
                    borderRadius: BorderRadius.circular(5)),
                suffixIcon: const Icon(Icons.search),
                suffixIconColor: bgColor),
            onSubmitted: (String searchValue) async {
              setState(() {
                isLoading = true;
              });
              books = await fetchSearchBooks(searchValue);
              setState(() {
                isLoading = false;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          isLoading
              ? const Expanded(
                  child: Center(
                      child: CircularProgressIndicator(
                  color: bgColor,
                )))
              : Expanded(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10),
                      itemCount: books.length,
                      padding:
                          const EdgeInsets.symmetric(vertical: defaultpd * 2),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "${books[index].thumb}.png"))),
                          child: Text('"${books[index].title}'),
                        );
                      }))
        ]),
      ),
    );
  }
}
