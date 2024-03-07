import 'package:flutter/material.dart';
import 'package:gh_app/core/account.dart';
import 'package:gh_app/core/borrowing_list_provider.dart';
import 'package:gh_app/core/constants.dart';
import 'package:gh_app/core/listing.dart';
import 'package:gh_app/core/listings.dart';
import 'package:gh_app/core/user_details.dart';
import 'package:gh_app/view/pages/assets/home_page.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();

  static Future<void> getBorrowingList(BuildContext context)  async {
    // try {
      var allListings = await supabase.from('order').select('*, item:item_id ( * )').eq('renter_id', supabase.auth.currentUser!.id);
      print(allListings);
      if (context.mounted) {
        context.read<BorrowingList>().clearList();

        
        for(var listing in allListings) {
          context.read<BorrowingList>().addItemFromMap(listing['item'], user);
        }
        print('test');
        print(context.read<BorrowingList>().borrowingList);
      }
    // } catch (error) {
    //   context.mounted ? context.showErrorSnackBar(message: 'Cant get Borrowing list') : null;
    // }
  }

  static Future<void> getListings(BuildContext context)  async {
    try {
    //   setState(() {
    //     _isLoading = true;
    //   });

      var allListings = await supabase.from('item').select('*');

      if (context.mounted) {
        getBorrowingList(context);
        listings.clear();
        myListings.clear();

        for(var listing in allListings) {
          if(listing["user_id"] == supabase.auth.currentUser!.id) {
            myListings.add(Listing.from_map(listing, user));
          } else {
            listings.add(Listing.from_map(listing, user));
          }
        }
      }

    } catch (error) {
      context.mounted ? context.showErrorSnackBar(message: 'Cant load listings') : null;
    }
  }
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }



  Future<void> login() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final response = await supabase.auth.signInWithPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      
      var userDetailsList = await supabase.from('user').select('*').eq('id', response.user!.id);
      var userDetails = userDetailsList[0];

      if (mounted) {
        user = Account(userDetails['first_name'], userDetails['last_name'], userDetails['email'], userDetails['id'], userDetails['mobile']);
        
        await LoginPage.getListings(context);
        if (mounted) {
          // route to next page
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const HomePage()));
        }
      }
    } on AuthException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (error) {
      context.showErrorSnackBar(message: 'Unexpected error occurred');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "required";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        // border: InputBorder.none,
                        border: const OutlineInputBorder(),
                        filled: true,
                        fillColor:
                            Theme.of(context).colorScheme.secondaryContainer,
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
                        return null;
                      },
                      decoration: InputDecoration(
                        // border: InputBorder.none,
                        border: const OutlineInputBorder(),
                        filled: true,
                        fillColor:
                            Theme.of(context).colorScheme.secondaryContainer,
                        labelText: 'Password',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: FilledButton.tonal(
                          onPressed: () => login(),
                          child: Container(
                              height: 50,
                              width: 200,
                              alignment: Alignment.center,
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ))),
                    ),
                    Padding(
                      //for testing purposes; byspasses teh e
                      padding: const EdgeInsets.all(20.0),
                      child: FilledButton.tonal(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              )),
                          child: Container(
                              height: 50,
                              width: 200,
                              alignment: Alignment.center,
                              child: const Text(
                                'Login bypass',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ))),
                    )
                  ],
                ),
              ))),
    );
  }
}
