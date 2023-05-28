import 'package:camera/camera.dart';
import 'package:gh_app/core/account.dart';
import 'package:gh_app/core/listing.dart';


List<Listing> listings = [
  Listing('Bluetooth Speaker', 'Bluetooth speaker, works perfectly fine. is water proof', 2.0, "Guelph, ON N1G", DateTime.parse('2023-05-18'), DateTime.parse('2023-06-20'), XFile('../assets/images/speaker.jpg'), Account("Mussab", "mussab@mail.com", "Password", "905999999"), ListingStatus.available),
];
