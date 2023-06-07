import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

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

Future<List<DocumentSnapshot>> getFavoriteBooksByUser() async {
  try {
    QuerySnapshot querySnapshot = await db
        .collection("favorites_books")
        .where("userID", isEqualTo: userId)
        .get();

    List<DocumentSnapshot> documents = querySnapshot.docs;
    return documents;
  } catch (error) {
    print('Erro ao obter os livros favoritados: $error');
    return [];
  }
}
