import 'package:flutter/material.dart';
import 'package:livraria_da_domitilda/views/login_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    home: LoginPage(),
  ));
}
