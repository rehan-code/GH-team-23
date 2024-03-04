import 'package:flutter/material.dart';
import 'package:gh_app/core/constants.dart';
import 'package:gh_app/core/listing.dart';
import 'package:gh_app/core/listings.dart';
import 'package:gh_app/core/user_details.dart';
import 'package:gh_app/view/pages/assets/confirm_pickup.dart';
import 'dart:io';
import 'package:gh_app/view/pages/assets/item_page.dart';

//Need to modify account class to include a list of your personally lent items, using listing is just temporary
//Need to maintain 2 lists, a rented list and a lent list

class MyLent extends StatefulWidget {
  const MyLent({super.key});

  @override
  State<MyLent> createState() => _MyLentItemsPage();
}

class _MyLentItemsPage extends State<MyLent> {

  bool _isLoading = false;

  // Future<void> getLendings()  async {
  //   try {
  //     setState(() {
  //       _isLoading = true;
  //     });

  //     var myLendings = await supabase.from('item').select('*').eq('user_id', supabase.auth.currentUser!.id);

  //     if (mounted) {
  //       listings.clear();

  //       for(var listing in myLendings) {

  //         listings.add(Listing.from_map(listing));

  //       }

  //     }

  //   } catch (error) {
  //     context.showErrorSnackBar(message: 'Cant load listings');
  //   } finally {
  //     if (mounted) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     }
  //   }
  // }

  @override
  void initState() {
    // getLendings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var listing in listings)
          if (listing.account.email == user.email)
            GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ConfirmPickup(
                        listing: listing,
                      ))),
              child: Card(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: Container(
                    height: 130,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                // color: Theme.of(context)
                                //     .colorScheme
                                //     .primaryContainer,
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
                                  children: <Widget>[
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
