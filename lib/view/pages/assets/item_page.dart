import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gh_app/core/listing.dart';
import 'package:gh_app/view/pages/assets/checkout_page.dart';

class ItemPage extends StatelessWidget {
  final Listing listing;
  const ItemPage({super.key, required this.listing});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              // color: Theme.of(context).colorScheme.secondary,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // color: Theme.of(context)
                //     .colorScheme
                //     .primaryContainer,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(File(listing.pictureFile.path))),
              ),
            ),
            SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(child: BackButton()),
                  IconButton(onPressed: () {}, icon: Icon(Icons.share))
                ],
              ),
            )),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                listing.title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Text(
                '\$${listing.price}',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(14),
          child: Container(
              height: 150,
              child: Text(
                listing.description,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 24),
              )),
        ),
        Divider(),
        ElevatedButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CheckoutPage(
                          listing: listing,
                        ))),
            child: Text('Proceed'))
      ]),
    );
  }
}
