import 'package:flutter/material.dart';
import 'package:gh_app/core/account.dart';
import 'package:gh_app/core/listing.dart';

class BorrowingList with ChangeNotifier {
  List<Listing> borrowingList = [];

  void addItemFromMap(Map<String, dynamic> listing, Account user) {
    borrowingList.add(Listing.from_map(listing, user));
    notifyListeners();
  }

  void clearList() {
    borrowingList.clear();
    notifyListeners();
  }
}