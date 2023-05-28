import 'package:flutter/material.dart';
import 'package:gh_app/core/listing.dart';
import 'package:gh_app/view/pages/assets/order_confirmed_page.dart';

//Need to modify account class to include a list of your personally rented items, using listing is just temporary

class ConfirmPickup extends StatefulWidget {
  final Listing listing;
  const ConfirmPickup({super.key, required this.listing});

  @override
  State<ConfirmPickup> createState() => _ConfirmPickup();
}

class _ConfirmPickup extends State<ConfirmPickup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Theme.of(context).colorScheme.background,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(14),
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
                      Expanded(
                        child: Text("Listing Status",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 40,
                              // decoration: TextDecoration.underline,
                              decorationColor:
                                  Colors.white, // Set the underline color
                            )),
                      )
                    ],
                  ),
                  SizedBox(height: 250),
                  if (widget.listing.status == ListingStatus.unavailable)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current rental start date: ${widget.listing.startTime.year}-${widget.listing.startTime.month}-${widget.listing.startTime.day}',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Current rental end date: ${widget.listing.endTime.year}-${widget.listing.endTime.month}-${widget.listing.endTime.day}',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Current rental days left: ${widget.listing.getDaysLeft()}',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  if (widget.listing.status == ListingStatus.available)
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: FilledButton.tonal(
                          onPressed: () {
                            widget.listing.toggleStatus();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OrderConfirmedPage()),
                                (route) => false);
                          },
                          child: Container(
                              height: 50,
                              width: 200,
                              alignment: Alignment.center,
                              child: Text(
                                'Confirm Order Pickup',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ))),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
