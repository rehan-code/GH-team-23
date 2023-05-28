import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gh_app/core/listing.dart';
import 'package:gh_app/core/listings.dart';
import 'package:gh_app/view/pages/assets/item_page.dart';
import 'package:dart_openai/dart_openai.dart';

class ListingsPage extends StatefulWidget {
  const ListingsPage({super.key});

  @override
  State<ListingsPage> createState() => _ListingsPageState();
}

class _ListingsPageState extends State<ListingsPage> {
  final TextEditingController searchController = TextEditingController();
  final SearchController controller = SearchController();
  var items = [];
  var searchHistory = [];

  void queryListener() {
    search(searchController.text);
  }

  void searchListener() {
    search(controller.text);
  }

  @override
  void initState() {
    super.initState();
    searchController.addListener(queryListener);
    controller.addListener(searchListener);
  }

  @override
  void dispose() {
    searchController.removeListener(queryListener);
    searchController.dispose();
    controller.removeListener(searchListener);
    controller.dispose();
    super.dispose();
  }

  void search(String query) {
    if (query.isEmpty) {
      setState(() {
        for (var listing in listings) {
          items.clear();
          items.add(listing);
        }
      });
    } else {
      setState(() {
        for (var listing in listings) {
          if (listing.title.toLowerCase().contains(query.toLowerCase())) {
            items.clear();
            items.add(listing);
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SearchAnchor(
              searchController: controller,
              viewHintText: 'Search...',
              viewTrailing: [
                IconButton(
                  onPressed: () {
                    searchHistory.add(controller.text);
                    searchHistory = searchHistory.reversed.toSet().toList();
                    controller.closeView(controller.text);
                  },
                  icon: Icon(Icons.search_rounded),
                ),
                IconButton(
                    onPressed: () {
                      controller.clear();
                    },
                    icon: Icon(Icons.clear))
              ],
              viewLeading: IconButton(
                  onPressed: () {
                    items.clear();
                    controller.clear();
                    controller.closeView("");
                  },
                  icon: Icon(Icons.arrow_back_rounded)),
              builder: (context, controller) {
                return SearchBar(
                  leading: IconButton(
                    icon: Icon(Icons.search_rounded),
                    onPressed: () {},
                  ),
                  controller: controller,
                  hintText: 'AI Search',
                  onTap: () => controller.openView(),
                  shadowColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.transparent),
                );
              },
              suggestionsBuilder: (context, controller) {
                return [
                  Wrap(
                    children: List.generate(searchHistory.length, (index) {
                      final item = searchHistory[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 4.0,
                          right: 4.0,
                        ),
                        child: ChoiceChip(
                          label: Text(item),
                          selected: item == controller.text,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(24.0),
                          )),
                          onSelected: (value) {
                            search(item);
                            controller.closeView(item);
                          },
                        ),
                      );
                    }),
                  ),
                  if (controller.text.isNotEmpty) ...{
                    const Divider(),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];

                        return Card(
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
                                    tag: '${item.title}${item.description}',
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        // color: Theme.of(context)
                                        //     .colorScheme
                                        //     .primaryContainer,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(
                                                File(item.pictureFile.path))),
                                      ),
                                      height: 110,
                                      width: 110,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${item.title[0].toUpperCase()}${item.title.substring(1)}',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              item.description,
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
                                      '\$${item.price}',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  }
                ];
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: items.isEmpty ? listings.length : items.length,
                itemBuilder: (context, index) {
                  final item = items.isEmpty ? listings[index] : items[index];

                  return Card(
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
                              tag: '${item.title}${item.description}',
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  // color: Theme.of(context)
                                  //     .colorScheme
                                  //     .primaryContainer,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(
                                          File(item.pictureFile.path))),
                                ),
                                height: 110,
                                width: 110,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${item.title[0].toUpperCase()}${item.title.substring(1)}',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        item.description,
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
                                '\$${item.price}',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    ));
  }
}
