import 'package:camera/camera.dart';
import 'package:gh_app/core/account.dart';

enum ListingStatus { available, unavailable }

class Listing {
  String title;
  String description;
  double price;
  String location;
  DateTime startTime;
  DateTime endTime;
  XFile pictureFile;
  Account account;
  ListingStatus status;

  DateTime? rentalStart;
  DateTime? rentalEnd;
  // String category;

  Listing(
      this.title,
      this.description,
      this.price,
      this.location,
      this.startTime,
      this.endTime,
      this.pictureFile,
      this.account,
      this.status);

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'location': location,
      'startTime': startTime,
      'endTime': endTime,
      'image': pictureFile
    };
  }

  void startRental(DateTime startTime, DateTime endTime) {
    rentalStart = startTime;
    rentalEnd = endTime;
    toggleStatus();
  }

  void endRental() {
    rentalStart = null;
    rentalEnd = null;
    toggleStatus();
  }

  void toggleStatus() {
    if (status == ListingStatus.available) {
      status = ListingStatus.unavailable;
    } else {
      status = ListingStatus.available;
    }
  }

  // change this when you add the rent start/end date for a listing
  int getDaysLeft() {
    DateTime now = DateTime.now();
    return rentalEnd!.difference(now).inDays;
  }

  @override
  String toString() {
    return toMap().toString();
  }
}