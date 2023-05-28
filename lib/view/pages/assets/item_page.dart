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
            Hero(
              tag: '${listing.title}${listing.description}',
              child: Container(
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
                    image: FileImage(File(listing.pictureFile.path)),
                    colorFilter:
                        ColorFilter.mode(Colors.black45, BlendMode.darken),
                  ),
                ),
              ),
            ),
            SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    child: BackButton(),
                    backgroundColor: Colors.white,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.share,
                        color: Colors.white,
                      ))
                ],
              ),
            )),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  '${listing.title[0].toUpperCase()}${listing.title.substring(1)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  '\$${listing.price}',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              )
            ],
          ),
        ),
        Divider(height: 1),
        Padding(
          padding: const EdgeInsets.all(14),
          child: FittedBox(
              // height: 150,
              child: Text(
            listing.description,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
          )),
        ),
        Divider(),
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(15),
          child: FilledButton.tonal(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CheckoutPage(
                            listing: listing,
                          ))),
              child: Container(
                  height: 50,
                  width: 200,
                  alignment: Alignment.center,
                  child: Text(
                    'Rent this item',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ))),
        )
      ]),
    );
  }
}
