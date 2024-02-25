import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gh_app/core/listing.dart';
import 'package:gh_app/core/listings.dart';
import 'dart:io';
import 'package:gh_app/view/pages/assets/item_page.dart';
import 'package:gh_app/view/pages/assets/my_borrowing.dart';
import 'package:gh_app/view/pages/assets/my_lent.dart';
import 'package:gh_app/view/pages/assets/pickup_or_cancel.dart';
import 'package:gh_app/view/pages/assets/return_page.dart';

//Need to modify account class to include a list of your personally rented items, using listing is just temporary

class MyRentals extends StatefulWidget {
  const MyRentals({super.key});

  @override
  State<MyRentals> createState() => _MyRentalsPage();
}

class _MyRentalsPage extends State<MyRentals> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // return Scaffold(
    //   appBar: AppBar(
    //     elevation: 0,
    //     title: Text("My Rentals", style: Theme.of(context).textTheme.headlineMedium),
    //     centerTitle: true,
    //     automaticallyImplyLeading: false,
    //     backgroundColor: Theme.of(context).colorScheme.primaryContainer,
    //     actions: <Widget>[
    //       IconButton(
    //         icon: const Icon(Icons.archive),
    //         tooltip: 'Show archived posts',
    //         onPressed: () {
    //           ScaffoldMessenger.of(context).showSnackBar(
    //               const SnackBar(content: Text('This is a snackbar')));
    //         },
    //       ),
    //     ],
    //   ),
      body:
    // );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: "Borrowing"),
              Tab(text: "Lending"),
            ],
          ),
          title: Text("My Rentals", style: Theme.of(context).textTheme.headlineMedium),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.archive),
              tooltip: 'Show archived posts',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('This is a snackbar')));
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(14),
              child: const TabBarView(
                children: [
                  MyBorrowings(),
                  MyLent(),
                ],
              ),
          ),
        ),
      ),
    );

  }
}
