// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';

import '../../models/book.dart';
import '../detail_page.dart';
import 'constants.dart';

class BookCard extends StatelessWidget {
  const BookCard({super.key, required this.thisbook, required this.isFavorite});

  final Books thisbook;
  final bool isFavorite;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        // ignore: avoid_print
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

class BookCardList extends StatelessWidget {
  const BookCardList(
      {super.key, required this.thisbook, required this.isFavorite});

  final Books thisbook;
  final bool isFavorite;

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
          MaterialPageRoute(
              builder: (context) => DetailPage(
                    detailBook: thisbook,
                    isFavorite: isFavorite,
                  )),
        );
      },
      child: SizedBox(
        width: double.infinity,
        height: 130,
        child: GestureDetector(
          child: Row(children: [
            Container(
              margin: const EdgeInsets.all(defaultpd / 2),
              height: 150,
              width: 80,
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(thisbook.thumb), fit: BoxFit.cover)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultpd * 1.4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    truncateText(thisbook.title, 35),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    truncateText(thisbook.publisher, 40),
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const Spacer(),
                  thisbook.authors.isEmpty
                      ? const Text(
                          '-',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      : Text(thisbook.authors.join(', '))
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
