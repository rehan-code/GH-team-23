import 'package:flutter/material.dart';
import 'package:gh_app/core/user_details.dart';
import 'package:gh_app/view/pages/assets/update_profile.dart';
import 'package:gh_app/view/pages/assets/welcome_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            CircleAvatar(
              radius: 75,
            ),
            SizedBox(
              height: 15,
            ),
            Text(user.name,
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
            )),
            SizedBox(
              height: 20,
            ),
            ListTile(
                title: Text(
              "My Lent Items",
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
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
              onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WelcomeScreen(),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
