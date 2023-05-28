import 'package:flutter/material.dart';
import 'package:gh_app/core/listings.dart';
import 'dart:io';
import 'package:gh_app/view/pages/assets/item_page.dart';

//Need to modify account class to include a list of your personally rented items, using listing is just temporary

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

                Row(
                  children: [
                    Expanded(child: Text("My rented items",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          // decoration: TextDecoration.underline,
                          decorationColor: Colors.white, // Set the underline color
                        )),)
                  ],
                ),

                for (var listing in listings)
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ItemPage(
                                listing: listing,
                              ))),
                      child: Card(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          child: Container(
                            height: 130,
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          // color: Theme.of(context)
                                          //     .colorScheme
                                          //     .primaryContainer,
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(File(listing.pictureFile.path)),
                                          ),
                                        ),
                                        height: 110,
                                        width: 110,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "${listing.title}",
                                                softWrap: true,
                                                style: TextStyle(
                                                  color: Colors.deepPurple,
                                                  fontSize: 16,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                              Text(
                                                "${listing.description}",
                                                softWrap: true,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          )),
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