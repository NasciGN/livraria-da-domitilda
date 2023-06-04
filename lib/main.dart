import 'package:flutter/material.dart';
import 'package:livraria_da_domitilda/views/favorites_books.dart';
import 'package:livraria_da_domitilda/views/home_screen.dart';
import 'package:livraria_da_domitilda/views/login_page.dart';
import 'package:livraria_da_domitilda/views/logon_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'modelviews/firebase/firebase_options.dart';
import 'package:get/get.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(GetMaterialApp(
    initialRoute: '/login',
    getPages: [
      GetPage(name: '/login', page: () => LoginPage()),
      GetPage(name: '/logon', page: () => LogOnPage()),
      GetPage(name: '/home', page: () => HomeScreen()),
      GetPage(name: '/favorite', page: () => FavoriteBooks()),
    ],
  ));
}
