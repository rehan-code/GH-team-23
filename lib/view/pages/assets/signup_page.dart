import 'package:flutter/material.dart';
import 'package:gh_app/core/constants.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var nameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneController = TextEditingController();
  var dobController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    lastNameController.dispose();
    dobController.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "required";
                        }
                        if (!RegExp(r"^[A-Za-z ,.'-]+$").hasMatch(value)) {
                          return "Enter a valid name";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                      ),
                    ),
                    TextFormField(
                      controller: lastNameController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "required";
                        }
                        if (!RegExp(r"^[A-Za-z ,.'-]+$").hasMatch(value)) {
                          return "Enter a valid name";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Last Name',
                      ),
                    ),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "required";
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return "Please Enter a valid email";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                    TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "required";
                        }
                        if (!RegExp(
                                r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z])(?=.*[*.!@#$%^&(){}[\]:;<>,.?/~_+\-=|]).{8,32}$')
                            .hasMatch(value)) {
                          return "Password Requirements:\n1 number\n1 lowercase letter\n1 uppercase letter\n1 special character\ncharacter length 8-32";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                    ),
                    TextFormField(
                      controller: confirmPasswordController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "required";
                        }
                        if (!RegExp(
                                r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z])(?=.*[*.!@#$%^&(){}[\]:;<>,.?/~_+\-=|]).{8,32}$')
                            .hasMatch(value)) {
                          return "Password Requirements:\n1 number\n1 lowercase letter\n1 uppercase letter\n1 special character\ncharacter length 8-32";
                        }
                        if (value != confirmPasswordController.text) {
                          return "Passwords must match";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                      ),
                    ),
                    TextFormField(
                      controller: dobController,
                      keyboardType: TextInputType.none,
                      validator: (value) {
                        if (dobController.text == "") {
                          return "Required";
                        }
                        return null;
                      },
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1800),
                            lastDate: DateTime.now());
                        if (pickedDate != null) {
                          setState(() {
                            dobController.text =
                                pickedDate.toString().substring(0, 10);
                          });
                        } else if (mounted) {
                          context.showErrorSnackBar(
                              message: 'required, yyyy-mm-dd');
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'date of birth',
                      ),
                    ),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "required";
                        }
                        if (!RegExp(
                                r'^(\+\d{1,2}\s?)?1?\-?\.?\s?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$')
                            .hasMatch(value)) {
                          return "enter a valid phone number";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Sign up',
                          style: TextStyle(fontSize: 20),
                        ))
                  ],
                ),
              ))),
    );
    ;
  }
}
