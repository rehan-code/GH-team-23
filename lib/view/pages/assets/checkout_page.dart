import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gh_app/core/constants.dart';
import 'package:gh_app/core/listing.dart';

class CheckoutPage extends StatefulWidget {
  final Listing listing;
  const CheckoutPage({super.key, required this.listing});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {

  var startDateController = TextEditingController(text: '0000-00-00');
  var endDateController = TextEditingController(text: '0000-00-00');

  @override
  Widget build(BuildContext context) {

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
                    Expanded(child: Text("Item Checkout",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white, // Set the underline color
                        )),)
                  ],
                ),

                SizedBox(height: 16),

                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // color: Theme.of(context)
                            //     .colorScheme
                            //     .primaryContainer,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(File(widget.listing.pictureFile.path)),
                            ),
                          ),
                          height: 110,
                          width: 110,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "${widget.listing.title}",
                                  softWrap: true,
                                  style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.left,
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
                    Expanded(child: Text("Select your renting duration between ${widget.listing.startTime} and ${widget.listing.endTime}"))
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 45,
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
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(DateTime.now().year + 100));
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
                      width: MediaQuery.of(context).size.width / 2 - 45,
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
                          DateTime.parse(endDateController.text);
                          if (dob.difference(startDate).inDays < 0) {
                            return "Date must be after startDate";
                          }
                          return null;
                        },
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(DateTime.now().year + 100));
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
                    Text("COST SUMMARY",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontSize: 16,
                      ),
                    )
                  ],
                ),

                Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 50.0),
                            child: Text(
                              'Price per day:',
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                        Text(
                          '\$${widget.listing.price}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                ),

                Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 50.0),
                            child: Text(
                              'Number of days item is being rented for:',
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                        Text(
                          '${(DateTime.parse(endDateController.text).difference(DateTime.parse(startDateController.text))).inDays}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                ),

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
                              textAlign: TextAlign.right,
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                        Text(
                          '\$${widget.listing.price * (DateTime.parse(endDateController.text).difference(DateTime.parse(startDateController.text))).inDays}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                ),

                SizedBox(height: 16),

                Divider(),

                SizedBox(height: 16),

                ElevatedButton(
                    onPressed: (DateTime.parse(endDateController.text).difference(DateTime.parse(startDateController.text))).inDays > 0 ? () {} : null,
                    child: Text('Proceed')
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
