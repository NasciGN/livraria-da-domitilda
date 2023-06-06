import 'package:flutter/material.dart';
import 'package:livraria_da_domitilda/views/components/constants.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
      ),
      body: const Column(children: [
        Center(
          child: Text('This is a detail page view.'),
        )
      ]),
    );
  }
}
