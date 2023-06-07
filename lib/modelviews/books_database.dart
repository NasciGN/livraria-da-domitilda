import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:livraria_da_domitilda/models/book.dart';
import 'package:logger/logger.dart';

import 'google_books.dart';

var logger = Logger();
final db = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;
final User? currentUser = auth.currentUser;
String? userId = currentUser?.uid;

Future<void> saveFavoriteBook(final bookId) async {
  final favoriteBook = <String, String>{
    "userID": "$userId",
    "bookID": "$bookId"
  };

  await db.collection("favorites_books").add(favoriteBook);
}

Future<List<Books>> getFavoriteBooksByUser() async {
  String bookID;
  List<Books> booksLiked = [];
  try {
    QuerySnapshot querySnapshot = await db
        .collection("favorites_books")
        .where("userID", isEqualTo: userId)
        .get();

    List<DocumentSnapshot> documents = querySnapshot.docs;
    for (DocumentSnapshot document in documents) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      bookID = data['bookID'];
      Books? currentBook = await fetchBook(bookID);
      if (currentBook != null) {
        booksLiked.add(currentBook);
      }
    }
  } catch (error) {
    print('Erro ao obter os livros favoritados: $error');
  }
  return booksLiked;
}
