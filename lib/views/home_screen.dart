import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livraria_da_domitilda/models/book.dart';
import 'package:livraria_da_domitilda/modelviews/google_books.dart';
import 'package:livraria_da_domitilda/views/components/constants.dart';
import 'package:livraria_da_domitilda/views/login_page.dart';

import '../modelviews/books_database.dart';
import 'components/cards.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final booksLiked = <Books>[].obs;
List<Books> books = [];
bool isLoading = false;

Future<void> fetchFavoritesBooks() async {
  List<Books> fetchedBooksLiked = await getFavoriteBooksByUser();
  booksLiked.assignAll(fetchedBooksLiked);
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
  void initState() {
    fetchFavoritesBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: defaultpd, vertical: defaultpd * 2),
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
            /* ElevatedButton(
               onPressed: () async {
                 setState(() {
                   isLoading = true;
                 });
                 await fetchFavoritesBooks();
                 setState(() {
                   isLoading = false;
                 });
               },
               child: const Text('BUSCAR')), */
            Expanded(
              child: Obx(() => ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: booksLiked.length,
                    itemBuilder: (BuildContext context, int index) {
                      return BookCardList(
                        thisbook: booksLiked[index],
                        isFavorite: true,
                      );
                    },
                  )),
            )
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Home',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut().then((_) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
                });
              },
              child: const Icon(Icons.logout_rounded),
            ),
          ],
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
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, childAspectRatio: 0.75),
                        itemCount: books.length,
                        padding:
                            const EdgeInsets.symmetric(vertical: defaultpd * 2),
                        itemBuilder: (BuildContext context, int index) {
                          final bookIds =
                              booksLiked.map((book) => book.id).toList();
                          return BookCard(
                            isFavorite: bookIds.contains(books[index].id),
                            thisbook: books[index],
                          );
                        }))
      ]),
    );
  }
}
