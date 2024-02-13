import 'package:flutter/material.dart';
import 'package:flutter_application_111_copy/Auth/majlisgram_home.dart';
import 'package:flutter_application_111_copy/Auth/signin_scree.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Add a delay of 2-3 seconds before navigating the user
    Future.delayed(Duration(seconds: 3), () {
      navigateUser();
    });
  }

  void navigateUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MajlisgramHome()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network("https://www.48hourslogo.com/48hourslogo_data/2015/07/15/201507151540519778.jpg"),// Your app logo image widget goes here
            // Example: Image.asset('assets/images/logo.png'),

            SizedBox(height: 20),

            CircularProgressIndicator(), // Optional: Show a loading indicator
          ],
        ),
      ),
    );
  }
}
