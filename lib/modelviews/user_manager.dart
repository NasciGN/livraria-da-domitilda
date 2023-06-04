import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:livraria_da_domitilda/modelviews/utils/snack_bar.dart';

Future<void> createUser(email, pass) async {
  try {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: pass,
    );
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

Future<void> loginUser(context, email, pass) async {
  try {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pass);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      showSnackBar(context, 'Wait, who are you?!',
          'This user was not found in our database...');
      //print('No user found for that email.');
      throw Exception('No user found for that email.');
    } else if (e.code == 'auth/wrong-password') {
      showSnackBar(context, 'Oh no, !',
          'The password entered seems incorrect, try to recover it through the button "Forgot your password?"');
      //print('Wrong password provided for that user.');
      throw Exception('Wrong password provided for that user.');
    } else {
      showSnackBar(context, 'Ops...',
          'Something is not right, please contact the administrator.');
      throw Exception('Error occurred: ${e.message}');
    }
  } catch (e) {
    //print('Error occurred: $e');
    throw Exception('Error occurred: $e');
  }
}
