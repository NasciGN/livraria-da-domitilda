import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:livraria_da_domitilda/modelviews/utils/snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;
final User? currentUser = auth.currentUser;
String? userId = currentUser?.uid;

Future<void> createUser(email, pass) async {
  try {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: pass,
    );
    String userId = credential.user?.uid ?? '';
    saveUserRegister(userId, email);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      SnackBar(
        content: AwesomeSnackbarContent(
            title: 'Oh no...',
            message: 'The password provided is too weak.',
            contentType: ContentType.failure),
      );
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}

Future<void> saveUserRegister(
  final userId,
  userEmail,
) async {
  final registerUser = <String, String>{
    "createDt": "${FieldValue.serverTimestamp()}",
    "userID": "$userId",
    "userEmail": "$userEmail",
  };

  try {
    await db.collection("users").add(registerUser);
    print('--------- USUARIO CADASTRADO NO FIRESTORE');
  } catch (e) {
    print('Erro ao cadastrar o usuário: $e');
  }
}

Future<void> loginUser(context, email, pass) async {
  try {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pass);
    showSnackBar(context, 'Oh Yeah!', "You are logged in, let's go");
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      showBadSnackBar(context, 'Wait, who are you?!',
          'This user was not found in our database...');
      //print('No user found for that email.');
      throw Exception('No user found for that email.');
    } else if (e.code == 'auth/wrong-password') {
      showBadSnackBar(context, 'Oh no, !',
          'The password entered seems incorrect, try to recover it through the button "Forgot your password?"');
      //print('Wrong password provided for that user.');
      throw Exception('Wrong password provided for that user.');
    } else {
      showBadSnackBar(context, 'Ops...',
          'Something is not right, please contact the administrator.');
      throw Exception('Error occurred: ${e.message}');
    }
  } catch (e) {
    //print('Error occurred: $e');
    throw Exception('Error occurred: $e');
  }
}
