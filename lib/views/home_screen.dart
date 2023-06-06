import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:livraria_da_domitilda/models/book.dart';
import 'package:livraria_da_domitilda/modelviews/google_books.dart';
import 'package:livraria_da_domitilda/views/components/constants.dart';
import 'package:livraria_da_domitilda/views/detail_page.dart';

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
      backgroundColor: Colors.white,
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
                  margin: const EdgeInsets.symmetric(vertical: 120),
                  child: Center(
                    child: Column(
                      children: [
                        Image.asset('assets/images/no_search_books.png'),
                        const SizedBox(
                          height: 40,
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
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 0.70),
                          itemCount: books.length,
                          padding: const EdgeInsets.symmetric(
                              vertical: defaultpd * 2),
                          itemBuilder: (BuildContext context, int index) {
                            return BookCard(
                              thisbook: books[index],
                            );
                          }))
        ]),
      ),
      bottomNavigationBar: const BottomNavigatorBar(),
    );
  }
}

class BookCard extends StatelessWidget {
  const BookCard({super.key, required this.thisbook});

  final Books thisbook;
  String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        print('This is a longpress');
      },
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DetailPage()),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 200,
            height: 250,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red,
                image:
                    DecorationImage(image: NetworkImage('${thisbook.thumb}'))),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  truncateText("${thisbook.title}", 17),
                  style: const TextStyle(color: bgColor),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.bookmark_outlined,
                      color: bgColor,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class BottomNavigatorBar extends StatefulWidget {
  const BottomNavigatorBar({
    super.key,
  });

  @override
  State<BottomNavigatorBar> createState() => _BottomNavigatorBarState();
}

class _BottomNavigatorBarState extends State<BottomNavigatorBar> {
  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    void _onTabTapped(int index) {
      setState(() {
        currentIndex = index;
      });
    }

    return BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: _onTabTapped,
        items: [
          const BottomNavigationBarItem(
              label: "Home",
              icon: Icon(
                Icons.home,
                color: bgColor,
              )),
          BottomNavigationBarItem(
            label: "Swap",
            icon: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.swap_horizontal_circle,
                color: bgColor,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: "My Library",
            icon: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.bookmarks,
                color: bgColor,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: "Swap",
            icon: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.person,
                color: bgColor,
              ),
            ),
          )
        ]);
  }
}
