import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

Future<void> saveFavoriteBook(final bookId) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  final User? currentUser = auth.currentUser;
  String? userId = currentUser?.uid;
  DatabaseReference ref =
      FirebaseDatabase.instance.ref("favorite_books/$bookId");

  print("UserID: $userId");
  await ref.set({
    "bookId": bookId,
    "userId": userId,
  }).then((value) {
    print('Dados enviados com sucesso!');
  }).catchError((error) {
    print('Erro ao enviar os dados: $error');
  });
}
