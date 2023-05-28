import 'package:flutter/material.dart';

class MyLent extends StatefulWidget {
  const MyLent({super.key});

  @override
  State<MyLent> createState() => _MyLentItemsPage();
}

class _MyLentItemsPage extends State<MyLent>{
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