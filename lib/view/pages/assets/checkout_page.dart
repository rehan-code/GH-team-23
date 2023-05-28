import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gh_app/core/constants.dart';
import 'package:gh_app/core/listing.dart';
import 'package:gh_app/view/pages/assets/pickup_or_cancel.dart';

class CheckoutPage extends StatefulWidget {
  final Listing listing;
  const CheckoutPage({super.key, required this.listing});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  var startDateController = TextEditingController();
  var endDateController = TextEditingController();

  int getNumDays() {
    return startDateController.text.isEmpty || endDateController.text.isEmpty
        ? 0
        : (DateTime.parse(endDateController.text)
                .difference(DateTime.parse(startDateController.text)))
            .inDays;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Align(alignment: Alignment.centerLeft, child: BackButton()),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Checkout",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40, // Set the underline color
                    )),
              ),
              SizedBox(height: 16),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag:
                            '${widget.listing.title}${widget.listing.description}',
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // color: Theme.of(context)
                            //     .colorScheme
                            //     .primaryContainer,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(
                                  File(widget.listing.pictureFile.path)),
                            ),
                          ),
                          height: 110,
                          width: 110,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.listing.title[0].toUpperCase()}${widget.listing.title.substring(1)}',
                                softWrap: true,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                                // textAlign: TextAlign.left,
                              ),
                              Text(
                                "${widget.listing.description}",
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
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Divider(),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    "Select your renting duration between ${widget.listing.startTime.year}-${widget.listing.startTime.month}-${widget.listing.startTime.day} and ${widget.listing.endTime.year}-${widget.listing.endTime.month}-${widget.listing.endTime.day}",
                    style: TextStyle(fontSize: 16),
                  ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 30,
                    child: TextFormField(
                      controller: startDateController,
                      keyboardType: TextInputType.none,
                      validator: (value) {
                        if (startDateController.text == "") {
                          return "Required";
                        }
                        var dob = DateTime.parse(startDateController.text);
                        var today = DateTime.now();

                        if (dob.difference(today).inDays < 0) {
                          return "Date must be after today";
                        }
                        return null;
                      },
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate:
                              DateTime.now().isAfter(widget.listing.startTime)
                                  ? DateTime.now()
                                  : widget.listing.endTime,
                          firstDate:
                              DateTime.now().isAfter(widget.listing.startTime)
                                  ? DateTime.now()
                                  : widget.listing.endTime,
                          lastDate: widget.listing.endTime,
                        );
                        if (pickedDate != null) {
                          setState(() {
                            print(pickedDate);
                            startDateController.text =
                                pickedDate.toString().substring(0, 10);
                          });
                        } else if (mounted) {
                          context.showErrorSnackBar(
                              message: 'required, yyyy-mm-dd');
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Start date',
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 30,
                    child: TextFormField(
                      controller: endDateController,
                      keyboardType: TextInputType.none,
                      validator: (value) {
                        if (endDateController.text == "") {
                          return "Required";
                        }
                        var dob = DateTime.parse(endDateController.text);
                        var today = DateTime.now();

                        if (dob.difference(today).inDays < 0) {
                          return "Date must be after today";
                        }
                        var startDate =
                            DateTime.parse(startDateController.text);
                        if (dob.difference(startDate).inDays < 0) {
                          return "Date must be after startDate";
                        }
                        return null;
                      },
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate:
                              DateTime.now().isAfter(widget.listing.startTime)
                                  ? DateTime.now()
                                  : widget.listing.endTime,
                          firstDate:
                              DateTime.now().isAfter(widget.listing.startTime)
                                  ? DateTime.now()
                                  : widget.listing.endTime,
                          lastDate: widget.listing.endTime,
                        );
                        if (pickedDate != null) {
                          setState(() {
                            endDateController.text =
                                pickedDate.toString().substring(0, 10);
                          });
                        } else if (mounted) {
                          context.showErrorSnackBar(
                              message: 'required, yyyy-mm-dd');
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'End date',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Divider(),
              SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    "COST SUMMARY",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 16,
                    ),
                  )
                ],
              ),
              SizedBox(height: 16),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 50.0),
                          child: Text(
                            'Price per day:',
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Text(
                        '\$${widget.listing.price}',
                      ),
                    ],
                  )),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 50.0),
                          child: Text(
                            'Number of rental days:',
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Text(
                        '${getNumDays()}',
                      ),
                    ],
                  )),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 50.0),
                          child: Text(
                            'Total',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      Text(
                        '\$${widget.listing.price * getNumDays()}',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 16),
              Divider(),
              Spacer(),
              FilledButton.tonal(
                onPressed: getNumDays() > 0
                    ? () {
                        widget.listing.startRental(
                            DateTime.parse(startDateController.text),
                            DateTime.parse(endDateController.text));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PickupOrCancel(listing: widget.listing)));
                      }
                    : null,
                child: Container(
                    height: 50,
                    width: 200,
                    alignment: Alignment.center,
                    child: Text(
                      'Proceed',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    )),
              ),
              SizedBox(height: 14),
            ],
          ),
        ),
      ),
    );
  }
}
