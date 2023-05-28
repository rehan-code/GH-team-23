import 'package:flutter/material.dart';
import 'package:gh_app/core/listing.dart';

//Need to modify account class to include a list of your personally rented items, using listing is just temporary

class PickupOrCancel extends StatefulWidget {
  final Listing listing;
  const PickupOrCancel({super.key, required this.listing});

  @override
  State<PickupOrCancel> createState() => _PickupOrCancel();
}

class _PickupOrCancel extends State<PickupOrCancel>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Theme.of(context).colorScheme.background,
          child: SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      // Handle back button press
                      Navigator.pop(context);
                    },
                  ),
                ),

                Row(
                  children: [
                    Expanded(child: Text("Pickup or Cancel",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          // decoration: TextDecoration.underline,
                          decorationColor: Colors.white, // Set the underline color
                        )),)
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(15),
                  child: FilledButton.tonal(
                      onPressed: () => {},
                      child: Container(
                          height: 50,
                          width: 200,
                          alignment: Alignment.center,
                          child: Text(
                            'Confirm Order Pickup',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                          ))
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(15),
                  child: FilledButton.tonal(
                      onPressed: () => {},
                      child: Container(
                          height: 50,
                          width: 200,
                          alignment: Alignment.center,
                          child: Text(
                            'Cancel Order',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                          ))
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}