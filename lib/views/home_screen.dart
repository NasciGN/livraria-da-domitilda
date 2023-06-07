import 'package:flutter/material.dart';

import 'package:livraria_da_domitilda/models/book.dart';
import 'package:livraria_da_domitilda/modelviews/google_books.dart';
import 'package:livraria_da_domitilda/views/components/constants.dart';
import 'package:livraria_da_domitilda/views/detail_page.dart';

import '../modelviews/books_database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<Books> books = [];
List<Books> booksLiked = [];
bool isLoading = false;

Future<List<Books>> fetchFavoritesBooks() async {
  booksLiked = await getFavoriteBooksByUser();
  return booksLiked;
}

Future<List<Books>> fetchBooks(String search) async {
  books = await fetchSearchBooks(search);
  isLoading = true;
  return books;
}

class _HomeScreenState extends State<HomeScreen> {
  int paginaSelecionada = 0;

  @override
  Widget build(BuildContext context) {
    void _onTabTapped(int index) {
      setState(() {
        paginaSelecionada = index;
      });
    }

    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: IndexedStack(
          index: paginaSelecionada,
          children: const [
            SearchPage(),
            SwapPage(),
            LibraryPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: paginaSelecionada,
          onTap: _onTabTapped,
          items: const [
            BottomNavigationBarItem(
                label: "Home",
                icon: Icon(
                  Icons.home,
                  color: bgColor,
                )),
            BottomNavigationBarItem(
              label: "Swap",
              icon: Icon(
                Icons.swap_horizontal_circle,
                color: bgColor,
              ),
            ),
            BottomNavigationBarItem(
              label: "My Library",
              icon: Icon(
                Icons.bookmarks,
                color: bgColor,
              ),
            ),
          ],
        ));
  }
}

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(defaultpd * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'My Library',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.account_circle,
                    size: 40,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            const Text('Favorites Books'),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await fetchFavoritesBooks();
                  setState(() {
                    isLoading = false;
                  });
                  print("LISTA DE FILMES CURTIDOS: ${booksLiked.toList()}");
                },
                child: Text('BUSCAR')),
            Expanded(
                child: ListView.builder(
              itemCount: booksLiked.length,
              padding: const EdgeInsets.symmetric(vertical: defaultpd * 2),
              itemBuilder: (BuildContext context, int index) {
                return BookCard(
                  isFavorite: booksLiked.contains({books[index].id}),
                  thisbook: booksLiked[index],
                );
              },
            ))
          ],
        ),
      ),
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
                            isFavorite: booksLiked.contains({books[index].id}),
                            thisbook: books[index],
                          );
                        }))
      ]),
    );
  }
}

class BookCard extends StatelessWidget {
  const BookCard({super.key, required this.thisbook, required this.isFavorite});

  final Books thisbook;
  final bool isFavorite;
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
                    isFavorite: isFavorite,
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
                color: Colors.black12,
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
