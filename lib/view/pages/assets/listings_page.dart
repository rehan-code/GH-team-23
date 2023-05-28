import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gh_app/core/listings.dart';
import 'package:gh_app/view/pages/assets/item_page.dart';
import 'package:dart_openai/dart_openai.dart';

class ListingsPage extends StatefulWidget {
  const ListingsPage({super.key});

  @override
  State<ListingsPage> createState() => _ListingsPageState();
}

class _ListingsPageState extends State<ListingsPage> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: SearchBar(
            leading: Icon(Icons.search_rounded),
            controller: searchController,
            hintText: 'AI Search',
            shadowColor: MaterialStateProperty.resolveWith(
                (states) => Colors.transparent),
            // onChanged: ,
          ),
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
                    width: 130,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: '${listing.title}${listing.description}',
                            child: Container(
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
                          ),
                          Expanded(
                            child: Container(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${listing.title[0].toUpperCase()}${listing.title.substring(1)}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      listing.description,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
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
