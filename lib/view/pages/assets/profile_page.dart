import 'package:flutter/material.dart';
import 'package:gh_app/core/constants.dart';
import 'package:gh_app/core/user_details.dart';
import 'package:gh_app/view/pages/assets/login_page.dart';
import 'package:gh_app/view/pages/assets/update_profile.dart';
import 'package:gh_app/view/pages/assets/welcome_screen.dart';
import 'package:gh_app/view/pages/assets/my_listings.dart';
import 'package:gh_app/view/pages/assets/my_lendings.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _loading = false;

  Future<void> _signOut() async {
    try {
      await supabase.auth.signOut();
    } on AuthException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (error) {
      context.showErrorSnackBar(message: 'Unexpected error occurred');
    } finally {
      if (mounted) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => WelcomeScreen()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title:
            Text("PROFILE", style: Theme.of(context).textTheme.headlineMedium),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: ListView(
          children: [
            Icon(
              Icons.account_circle_rounded,
              size: 170,
            ),
            SizedBox(
              height: 15,
            ),
            Text(user!.firstName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(
              height: 60,
            ),
            ListTile(
              title: Text(
                "Edit Profile",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateProfile(),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              title: Text(
                "My Rentals",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyListingsPage(),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              title: Text(
                "My Listings",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyLendingsPage(),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
                title: Text(
              "Account Balance",
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app_rounded, color: Colors.red),
              title: Text(
                "Log Out",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              ),
              onTap: () => _signOut(),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(Icons.refresh),
              title: Text(
                "refresh listings",
                style:
                    TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () => LoginPage.getListings(context),
            ),
          ],
        ),
      ),
    );
  }
}
