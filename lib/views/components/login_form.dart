import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livraria_da_domitilda/modelviews/utils/snack_bar.dart';
import 'package:livraria_da_domitilda/views/components/constants.dart';
import 'package:livraria_da_domitilda/views/logon_page.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../modelviews/user_manager.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

TextEditingController _controllerEmail = TextEditingController();
TextEditingController _controllerPassword = TextEditingController();

final _formKey = GlobalKey<FormState>();
bool _validEmail = false;
bool _validPass = false;
bool _isObscure = true;
bool _isLoading = false;

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  void login() {}

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: size.height * .38,
              child: Column(children: [
                TextFormField(
                  controller: _controllerEmail,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: bgColor),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'This field is required!'),
                    EmailValidator(errorText: 'Invalid email!')
                  ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    obscureText: _isObscure,
                    controller: _controllerPassword,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                        labelText: 'password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: bgColor),
                            borderRadius: BorderRadius.circular(20)),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                          child: Icon(_isObscure
                              ? Icons.remove_red_eye
                              : Icons.remove_red_eye_outlined),
                        )),
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'This field is required!'),
                      LengthRangeValidator(
                          min: 6,
                          max: 20,
                          errorText:
                              'The password must have a min of 6 and a mix of 20 characters!')
                    ])),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                      onPressed: () async {},
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.black45),
                      )),
                ),
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isLoading = true;
                      });
                      await loginUser(context, _controllerEmail.text,
                          _controllerPassword.text);

                      Get.toNamed('/home');
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: bgColor,
                        borderRadius:
                            BorderRadius.all(Radius.circular(defaultpd * 2))),
                    child: const Text(
                      'SIGN IN',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
                    ),
                  ),
                ),
              ]),
            ),
            const Text(
              "--------------  OR  --------------",
              style: TextStyle(fontSize: 15),
            ),
            Container(
              padding: const EdgeInsets.all(defaultpd / 2),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: size.width * 0.3,
                      height: 40,
                      decoration: const BoxDecoration(color: Colors.red),
                    ),
                    Container(
                      width: size.width * 0.3,
                      height: 40,
                      decoration: const BoxDecoration(color: Colors.red),
                    ),
                  ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  "Haven't account yet?  ",
                  style: TextStyle(color: Colors.black45),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LogOnPage()));
                  },
                  child: const Text(
                    "SIGN UP",
                    style: TextStyle(
                        fontSize: 20,
                        color: bgColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
