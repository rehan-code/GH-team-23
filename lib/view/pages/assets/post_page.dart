import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gh_app/core/account.dart';
import 'package:gh_app/core/accounts.dart';
import 'package:gh_app/core/constants.dart';
import 'package:gh_app/core/listing.dart';
import 'package:gh_app/core/listings.dart';
import 'package:gh_app/core/user_details.dart';
import 'package:gh_app/view/pages/assets/camera_page.dart';
import 'package:gh_app/view/pages/assets/home_page.dart';
import 'package:image_picker/image_picker.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  var locationController = TextEditingController();
  var categoryController = TextEditingController();
  var startTimeController = TextEditingController();
  var startDateController = TextEditingController();
  var endTimeController = TextEditingController();
  var endDateController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  XFile? pictureFile;

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    locationController.dispose();
    categoryController.dispose();
    startDateController.dispose();
    startTimeController.dispose();
    endDateController.dispose();
    endTimeController.dispose();
  }

  void getPicture(XFile picture) {
    setState(() {
      pictureFile = picture;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> post() async {
      if (formKey.currentState!.validate()) {
        var startTime = DateTime.parse(startDateController.text);
        var endTime = DateTime.parse(endDateController.text);
        if (pictureFile == null) {
          context.showErrorSnackBar(message: "Image required");
          return;
        }
        Listing listing = Listing(
            titleController.text,
            descriptionController.text,
            double.parse(priceController.text),
            locationController.text,
            startTime,
            endTime,
            pictureFile!,
            user!,
            ListingStatus.available);

        listings.add(listing); // delete when database added

        //add database insert
        final newListing = {
          'user_id': supabase.auth.currentUser!.id,
          'title': titleController.text.trim(),
          'description': descriptionController.text,
          'image': '', // figure out using buckets
          'price': double.parse(priceController.text),
          'status': ListingStatus.available.toString(),
          'availability_start': startDateController.text,
          'availability_end': endDateController.text,
          'safetyDeposit': 0.0,
          // 'location': locationController.text,
        };
        await supabase.from('item').insert(newListing);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        if (mounted) {
          context.showSnackBar(message: 'Listing Successfully added');
        }
      }
    }

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Create a new Listing',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: pictureFile == null
                            ? Theme.of(context).colorScheme.primaryContainer
                            : null,
                        image: pictureFile == null
                            ? null
                            : DecorationImage(
                                image: FileImage(File(pictureFile!.path)),
                                fit: BoxFit.cover),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(15)),
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.3,
                    margin: EdgeInsets.only(top: 20),
                    child: FilledButton.tonal(
                      style: FilledButton.styleFrom(
                          backgroundColor: Colors.transparent, elevation: 0),
                      onPressed: () async {
                        await availableCameras().then(
                          (value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CameraPage(
                                cameras: value,
                                callback: getPicture,
                              ),
                            ),
                          ),
                        );
                      },
                      child: pictureFile == null ? Icon(Icons.camera) : null,
                      // : Image.file(File(pictureFile!.path)),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: titleController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      // border: InputBorder.none,
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor:
                          Theme.of(context).colorScheme.secondaryContainer,
                      labelText: 'Title',
                    ),
                  ),
                  TextFormField(
                    controller: descriptionController,
                    maxLines: 4,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      // border: InputBorder.none,
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor:
                          Theme.of(context).colorScheme.secondaryContainer,
                      labelText: 'Description',
                    ),
                  ),
                  TextFormField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "required";
                      }
                      if (!RegExp(r"^[0-9.]+$").hasMatch(value)) {
                        return "Enter a valid price";
                      }
                      if (double.tryParse(value) == null) {
                        return "Enter a valid price";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      // border: InputBorder.none,
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor:
                          Theme.of(context).colorScheme.secondaryContainer,
                      labelText: 'Price',
                    ),
                  ),
                  TextFormField(
                    controller: locationController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      // border: InputBorder.none,
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor:
                          Theme.of(context).colorScheme.secondaryContainer,
                      labelText: 'Location',
                    ),
                  ),
                  TextFormField(
                    controller: categoryController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      // if (value == null || value.isEmpty) {
                      //   return "required";
                      // }
                      return null;
                    },
                    decoration: InputDecoration(
                      // border: InputBorder.none,
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor:
                          Theme.of(context).colorScheme.secondaryContainer,
                      labelText: 'Category',
                    ),
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
                            labelText: 'start availability',
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
                                DateTime.parse(startDateController.text);
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
                            labelText: 'end availability',
                          ),
                        ),
                      ),
                      // Container(
                      //   width: MediaQuery.of(context).size.width / 2 - 45,
                      //   child: TextFormField(
                      //     controller: startTimeController,
                      //     keyboardType: TextInputType.none,
                      //     validator: (value) {
                      //       if (startTimeController.text == "") {
                      //         return "Required";
                      //       }
                      //       // var today = DateTime.now();

                      //       return null;
                      //     },
                      //     onTap: () async {
                      //       TimeOfDay? pickedTime = await showTimePicker(
                      //         context: context,
                      //         initialTime: TimeOfDay.now(),
                      //         builder: (BuildContext context, Widget? child) {
                      //           return Directionality(
                      //             textDirection: TextDirection.rtl,
                      //             child: child!,
                      //           );
                      //         },
                      //       );
                      //       if (pickedTime != null) {
                      //         setState(() {
                      //           startTimeController.text =
                      //               '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                      //         });
                      //       } else if (mounted) {
                      //         context.showErrorSnackBar(
                      //             message: 'required, hh:mm');
                      //       }
                      //     },
                      //     decoration: const InputDecoration(
                      //       labelText: 'start time',
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  // Container(
                  //   width: MediaQuery.of(context).size.width / 2 - 45,
                  //   child: TextFormField(
                  //     controller: endTimeController,
                  //     keyboardType: TextInputType.none,
                  //     validator: (value) {
                  //       if (endTimeController.text == "") {
                  //         return "Required";
                  //       }

                  //       return null;
                  //     },
                  //     onTap: () async {
                  //       TimeOfDay? pickedTime = await showTimePicker(
                  //         context: context,
                  //         initialTime: TimeOfDay.now(),
                  //         builder: (BuildContext context, Widget? child) {
                  //           return Directionality(
                  //             textDirection: TextDirection.rtl,
                  //             child: child!,
                  //           );
                  //         },
                  //       );
                  //       if (pickedTime != null) {
                  //         setState(() {
                  //           endTimeController.text =
                  //               '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                  //         });
                  //       } else if (mounted) {
                  //         context.showErrorSnackBar(
                  //             message: 'required, hh:mm');
                  //       }
                  //     },
                  //     decoration: const InputDecoration(
                  //       labelText: 'start time',
                  //     ),
                  //   ),
                  // ),
                  //   ],
                  // ),
                  // Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: FilledButton.tonal(
                        onPressed: () => post(),
                        child: Container(
                            height: 50,
                            width: 200,
                            alignment: Alignment.center,
                            child: Text(
                              'Publish',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ))),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
