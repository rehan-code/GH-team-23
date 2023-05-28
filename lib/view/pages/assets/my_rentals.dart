import 'package:flutter/material.dart';

class MyRentals extends StatefulWidget {
  const MyRentals({super.key});

  @override
  State<MyRentals> createState() => _MyRentalsPage();
}

class _MyRentalsPage extends State<MyRentals>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Theme.of(context).colorScheme.background,
          child: SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      // Handle back button press
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}