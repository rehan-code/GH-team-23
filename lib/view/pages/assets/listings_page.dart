import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gh_app/core/listings.dart';
import 'package:gh_app/view/pages/assets/item_page.dart';

class ListingsPage extends StatelessWidget {
  const ListingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
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
                    width: 130,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              // color: Theme.of(context)
                              //     .colorScheme
                              //     .primaryContainer,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(
                                      File(listing.pictureFile.path))),
                            ),
                            height: 110,
                            width: 110,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Expanded(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      listing.title,
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(
                                      child: Text(
                                        listing.description,
                                        // overflow: TextOverflow.ellipsis,
                                        // softWrap: false,
                                        // maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Spacer(),
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              '\$${listing.price}',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          )
      ],
    );
  }
}
