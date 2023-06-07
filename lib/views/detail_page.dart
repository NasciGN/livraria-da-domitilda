import 'package:flutter/material.dart';
import 'package:livraria_da_domitilda/modelviews/books_database.dart';
import 'package:livraria_da_domitilda/modelviews/utils/snack_bar.dart';
import 'package:livraria_da_domitilda/views/components/bottom_bar.dart';
import 'package:livraria_da_domitilda/views/components/constants.dart';

import '../models/book.dart';
import '../modelviews/user_manager.dart';
import 'home_screen.dart';

class DetailPage extends StatefulWidget {
  Books detailBook;
  bool isFavorite;
  DetailPage({super.key, required this.detailBook, required this.isFavorite});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultpd),
        child: Column(children: [
          Container(
            margin: const EdgeInsets.all(defaultpd),
            width: size.width * 0.50,
            height: size.height * 0.4,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Cor da sombra
                    offset: const Offset(0, 3), // Deslocamento da sombra (x, y)
                    blurRadius: 4, // Raio de desfoque da sombra
                    spreadRadius: 2, // Propagação da sombra
                  ),
                ],
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage('${widget.detailBook.thumb}'),
                  fit: BoxFit.cover,
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () async {
                  setState(() {
                    widget.isFavorite = !widget.isFavorite;
                  });
                  if (widget.isFavorite) {
                    showSnackBar(context, 'Go to read!',
                        'This book has been added to your library.');
                    saveFavoriteBook('${widget.detailBook.id}');
                  }
                  await fetchFavoritesBooks();
                },
                child: widget.isFavorite
                    ? const Icon(
                        Icons.bookmark,
                        size: defaultpd * 3,
                        color: bgColor,
                      )
                    : const Icon(
                        Icons.bookmark_add_outlined,
                        size: defaultpd * 3,
                        color: bgColor,
                      ),
              ),
              GestureDetector(
                  onTap: () {
                    if (widget.isFavorite) {
                      print('Troca habilitada');
                    }
                  },
                  child: widget.isFavorite
                      ? const Icon(
                          Icons.swap_horizontal_circle,
                          size: defaultpd * 3,
                          color: bgColor,
                        )
                      : const Icon(
                          Icons.swap_horizontal_circle,
                          size: defaultpd * 3,
                          color: Colors.black12,
                        )),
            ],
          )
        ]),
      ),
    );
  }
}
