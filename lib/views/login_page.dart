import 'package:flutter/material.dart';
import 'package:livraria_da_domitilda/views/components/constants.dart';
import 'package:livraria_da_domitilda/views/components/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
            padding: const EdgeInsets.only(
                right: defaultpd * 3,
                left: defaultpd * 3,
                top: defaultpd * 3,
                bottom: defaultpd),
            margin: EdgeInsets.only(top: size.height * 0.4),
            height: size.height * 0.6,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(defaultpd * 2),
                    topRight: Radius.circular(defaultpd * 2))),
            child: const LoginForm(),
          ),
        ]),
      ),
    );
  }
}
