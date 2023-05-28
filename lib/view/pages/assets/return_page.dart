import 'package:flutter/material.dart';
import 'package:gh_app/core/listing.dart';
import 'package:gh_app/view/pages/assets/order_cancelled_page.dart';
import 'package:gh_app/view/pages/assets/order_confirmed_page.dart';
import 'package:gh_app/view/pages/assets/order_returned_page.dart';

//Need to modify account class to include a list of your personally rented items, using listing is just temporary

class ReturnPage extends StatefulWidget {
  final Listing listing;
  const ReturnPage({super.key, required this.listing});

  @override
  State<ReturnPage> createState() => _ReturnPage();
}

class _ReturnPage extends State<ReturnPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
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
                    child: Text("Return Item",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40, // Set the underline color
                        )),
                  )
                ],
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Return Address: ${widget.listing.location}',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Phone: ${widget.listing.account.phone}',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Days Left: ${widget.listing.getDaysLeft()}',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Return date: ${widget.listing.endTime.year}-${widget.listing.endTime.month}-${widget.listing.endTime.day}',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 200),
              Padding(
                padding: const EdgeInsets.all(14),
                child: FilledButton.tonal(
                  onPressed: () {
                    widget.listing.endRental();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderReturnedPage()),
                        (Route<dynamic> route) => false);
                  },
                  child: Container(
                      height: 50,
                      width: 200,
                      alignment: Alignment.center,
                      child: Text(
                        'Return Item',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      )),
                  style: FilledButton.styleFrom(
                      backgroundColor: Colors.green[600]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
