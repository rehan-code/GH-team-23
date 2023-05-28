import 'package:flutter/material.dart';
import 'package:gh_app/view/pages/assets/login_page.dart';
import 'package:gh_app/view/pages/assets/signup_page.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: Colors.white,
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  Text(
                    'Lendr',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        // color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  FilledButton.tonal(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
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
                  SizedBox(
                    height: 15,
                  ),
                  FilledButton.tonal(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupPage(),
                          )),
                      child: Container(
                          height: 50,
                          width: 200,
                          alignment: Alignment.center,
                          child: Text(
                            'Signup',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          )))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
