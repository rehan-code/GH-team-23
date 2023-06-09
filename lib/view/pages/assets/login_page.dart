import 'package:flutter/material.dart';
import 'package:gh_app/core/account.dart';
import 'package:gh_app/core/accounts.dart';
import 'package:gh_app/core/constants.dart';
import 'package:gh_app/core/user_details.dart';
import 'package:gh_app/view/pages/assets/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login() {
    // if (_formKey.currentState!.validate()) {
    //   for (var element in accounts) {
    //     if (element.email == emailController.text &&
    //         element.password == passwordController.text) {
    //       user = element;
    //       Navigator.push(
    //           context, MaterialPageRoute(builder: (context) => HomePage()));
    //     }
    //     context.showErrorSnackBar(message: 'Invalid Account');
    //   }
    // }

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "required";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        // border: InputBorder.none,
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor:
                            Theme.of(context).colorScheme.secondaryContainer,
                        labelText: 'Email',
                      ),
                    ),
                    TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "required";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        // border: InputBorder.none,
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor:
                            Theme.of(context).colorScheme.secondaryContainer,
                        labelText: 'Password',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: FilledButton.tonal(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              )),
                          child: Container(
                              height: 50,
                              width: 200,
                              alignment: Alignment.center,
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ))),
                    )
                  ],
                ),
              ))),
    );
  }
}
