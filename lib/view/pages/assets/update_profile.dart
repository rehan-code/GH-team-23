import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gh_app/core/account.dart';
import 'package:gh_app/core/accounts.dart';
import 'package:gh_app/core/constants.dart';
import 'package:gh_app/core/user_details.dart';
import 'package:gh_app/view/pages/assets/profile_page.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    phoneController.dispose();
  }

  void editProfile() {
    if (_formKey.currentState!.validate()) {
      user = Account(
          nameController.text.isNotEmpty ? nameController.text : user.name,
          user.email,
          passwordController.text.isNotEmpty
              ? passwordController.text
              : user.password,
          phoneController.text.isNotEmpty ? phoneController.text : user.phone);
      for (var element in accounts) {
        if (element.email == user.email) {
          element = user;
        }
      }
      Navigator.pop(context);
      if (mounted) {
        context.showSnackBar(message: 'Profile changed successfully');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Stack(
          children: [
            Container(
              height: 220,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).colorScheme.primary,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: CircleAvatar(
                  child: BackButton(),
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 150,
                ),
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.account_circle_rounded,
                      size: 150,
                    ),
                    radius: 75,
                  ),
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: TextFormField(
            controller: nameController,
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value != null &&
                  value.isNotEmpty &&
                  !RegExp(r"^[A-Za-z ,.'-]+$").hasMatch(value)) {
                return "Enter a valid name";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: 'Full Name',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: TextFormField(
            controller: passwordController,
            keyboardType: TextInputType.text,
            obscureText: true,
            validator: (value) {
              // if (!RegExp(
              //         r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z])(?=.*[*.!@#$%^&(){}[\]:;<>,.?/~_+\-=|]).{8,32}$')
              //     .hasMatch(value)) {
              //   return "Password Requirements:\n1 number\n1 lowercase letter\n1 uppercase letter\n1 special character\ncharacter length 8-32";
              // }

              if (value != null &&
                  value.isNotEmpty &&
                  !RegExp(r"^[A-Za-z0-9*.!@#$%^&(){}[\]:;<>,.?/~_+\-=|]+$")
                      .hasMatch(value)) {
                return "Enter a valid password";
              }
              return null;
            },
            decoration: InputDecoration(
              // border: InputBorder.none,
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Theme.of(context).colorScheme.secondaryContainer,
              labelText: 'Password',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: TextFormField(
            controller: confirmPasswordController,
            keyboardType: TextInputType.text,
            obscureText: true,
            validator: (value) {
              if (value != null &&
                  value.isNotEmpty &&
                  !RegExp(r"^[A-Za-z0-9*.!@#$%^&(){}[\]:;<>,.?/~_+\-=|]+$")
                      .hasMatch(value)) {
                return "Enter a valid password";
              }
              if (value != confirmPasswordController.text) {
                return "Passwords must match";
              }
              return null;
            },
            decoration: InputDecoration(
              // border: InputBorder.none,
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Theme.of(context).colorScheme.secondaryContainer,
              labelText: 'Confirm Password',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: TextFormField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value != null &&
                  value.isNotEmpty &&
                  !RegExp(r'^(\+\d{1,2}\s?)?1?\-?\.?\s?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$')
                      .hasMatch(value)) {
                return "enter a valid phone number";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: 'Phone Number',
            ),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        FilledButton.tonal(
            onPressed: () => {},
            child: Text(
              'Sign up',
              style: TextStyle(fontSize: 20),
            ))
      ],
    )));
  }
}
