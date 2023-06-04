import 'package:flutter/material.dart';

import '../modelviews/utils/snack_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {});
  }

  Widget build(BuildContext context) {
    return Scaffold(body: Center());
  }
}
