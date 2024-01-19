import 'package:flutter/material.dart';
import 'package:gh_app/core/constants.dart';
import 'package:gh_app/view/pages/assets/home_page.dart';
import 'package:gh_app/view/pages/assets/welcome_screen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(Duration.zero);
    if (!mounted) {
      return;
    }

    final session = supabase.auth.currentSession;
    if (session != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
      // Navigator.of(context).pushReplacementNamed('/account');
    } else {
      // Navigator.of(context).pushReplacementNamed('/login');
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const WelcomeScreen(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
