import 'package:flutter/material.dart';
import 'package:livraria_da_domitilda/views/login_page.dart';

import 'components/constants.dart';

class LogOnPage extends StatefulWidget {
  const LogOnPage({super.key});

  @override
  State<LogOnPage> createState() => _LogOnPageState();
}

class _LogOnPageState extends State<LogOnPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            "Already have an account?  ",
            style: TextStyle(color: Colors.black45),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
            child: const Text(
              "SIGN IN",
              style: TextStyle(
                  fontSize: 20, color: bgColor, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      )),
    );
  }
}
