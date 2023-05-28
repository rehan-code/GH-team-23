import 'package:camera/camera.dart';
import 'package:gh_app/core/account.dart';

class Listing {
  String title;
  String description;
  double price;
  String location;
  DateTime startTime;
  DateTime endTime;
  XFile pictureFile;
  Account account;
  // String category;

  Listing(this.title, this.description, this.price, this.location,
      this.startTime, this.endTime, this.pictureFile, this.account);

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

  @override
  String toString() {
    return toMap().toString();
  }
}
