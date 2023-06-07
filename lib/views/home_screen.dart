import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:livraria_da_domitilda/models/book.dart';
import 'package:livraria_da_domitilda/modelviews/google_books.dart';
import 'package:livraria_da_domitilda/views/components/constants.dart';
import 'package:livraria_da_domitilda/views/detail_page.dart';

import 'components/bottom_bar.dart';

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
  int paginaSelecionada = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: IndexedStack(
        index: paginaSelecionada,
        children: const [
          SearchPage(),
          SwapPage(),
        ],
      ),
      bottomNavigationBar: MyBottomNavigatorBar(),
    );
  }
}

class SwapPage extends StatefulWidget {
  const SwapPage({super.key});

  @override
  State<SwapPage> createState() => _SwapPageState();
}

class _SwapPageState extends State<SwapPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('SwapPage'),
      ),
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
              focusColor: bgColor,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: bgColor),
                  borderRadius: BorderRadius.circular(5)),
              labelStyle: const TextStyle(color: bgColor),
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
            print("Tamanho da lista de livros: ${books.length}");
          },
        ),
        const SizedBox(
          height: 10,
        ),
        books.isEmpty
            ? Container(
                margin: const EdgeInsets.symmetric(vertical: 80),
                child: Center(
                  child: Column(
                    children: [
                      Image.asset('assets/images/no_search_books.png'),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Nothing to see here...',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.black54),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Try search for a some book.',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              )
            : isLoading
                ? const Expanded(
                    child: Center(
                        child: CircularProgressIndicator(
                    color: bgColor,
                  )))
                : Expanded(
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, childAspectRatio: 0.75),
                        itemCount: books.length,
                        padding:
                            const EdgeInsets.symmetric(vertical: defaultpd * 2),
                        itemBuilder: (BuildContext context, int index) {
                          return BookCard(
                            thisbook: books[index],
                          );
                        }))
      ]),
    );
  }
}

class BookCard extends StatelessWidget {
  const BookCard({super.key, required this.thisbook});

  final Books thisbook;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        print('This is a longpress');
      },
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailPage(
                    detailBook: thisbook,
                  )),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 140,
            height: 200,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Cor da sombra
                    offset: const Offset(0, 3), // Deslocamento da sombra (x, y)
                    blurRadius: 4, // Raio de desfoque da sombra
                    spreadRadius: 2, // Propagação da sombra
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage('${thisbook.thumb}'),
                    fit: BoxFit.cover)),
          ),
        ],
      ),
    );
  }
}
