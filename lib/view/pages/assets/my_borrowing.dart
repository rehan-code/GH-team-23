import 'package:flutter/material.dart';
import 'package:gh_app/core/listing.dart';
import 'package:gh_app/core/listings.dart';
import 'dart:io';

import 'package:gh_app/view/pages/assets/return_page.dart';

class MyBorrowings extends StatefulWidget {
  const MyBorrowings({super.key});

  @override
  State<MyBorrowings> createState() => _MyBorrowingsPage();
}

class _MyBorrowingsPage extends State<MyBorrowings> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var listing in listings)
          if (listing.status == ListingStatus.unavailable)
            GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ReturnPage(listing: listing))),
              child: Card(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: Container(
                    height: 130,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(
                                      File(listing.pictureFile.path)),
                                ),
                              ),
                              height: 110,
                              width: 110,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${listing.title[0].toUpperCase()}${listing.title.substring(1)}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: Colors.deepPurple,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
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
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
      ],
    );
  }

}