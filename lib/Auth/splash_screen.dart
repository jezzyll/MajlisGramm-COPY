import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_111_copy/Auth/home_screen.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay for 3 seconds and then navigate to the home page
    Future.delayed(Duration(seconds: 3), () {
      navigateToHomePage();
    });
  }

  void navigateToHomePage() {
    // You can perform any additional checks here, like checking if the user is logged in
    // or if certain data needs to be fetched before navigating to the home page
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set your desired background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Your logo widget
            Image.asset(
              'assets/logo.png', // Path to your logo image asset
              width: 150.0, // Set the width of your logo
              height: 150.0, // Set the height of your logo
              // You can adjust these dimensions based on your design
            ),
            SizedBox(height: 20.0), // Add some spacing
            Text(
              'Your App Name', // Your app name
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Set your desired text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
