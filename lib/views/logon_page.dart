import 'package:flutter/material.dart';

import 'components/constants.dart';
import 'components/logon_form.dart';

class LogOnPage extends StatefulWidget {
  const LogOnPage({super.key});

  @override
  State<LogOnPage> createState() => _LogOnPageState();
}

class _LogOnPageState extends State<LogOnPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        reverse: true,
        child: Stack(children: [
          Container(
            margin: const EdgeInsets.only(top: defaultpd * 2),
            width: double.infinity,
            child: Column(
              children: [
                Image.asset(
                  'assets/images/books.png',
                  height: size.height * 0.25,
                ),
                const SizedBox(
                  height: defaultpd * 2,
                ),
                const Text(
                  "Your Book's",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 8,
                      fontSize: 30),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(defaultpd * 3),
            margin: EdgeInsets.only(top: size.height * 0.4),
            height: size.height * 0.65,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(defaultpd * 2),
                    topRight: Radius.circular(defaultpd * 2))),
            child: const LogOnForm(),
          ),
        ]),
      ),
    );
  }
}
