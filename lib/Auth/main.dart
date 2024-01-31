import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_111_copy/Auth/signin_scree.dart';
import 'package:flutter_application_111_copy/Auth/signup_screen.dart';
import 'package:flutter_application_111_copy/Offiice/office_Home.dart';
import 'package:flutter_application_111_copy/Offiice/office_non_staff.dart';
import 'package:flutter_application_111_copy/Offiice/office_staff.dart';
import 'package:flutter_application_111_copy/Offiice/office_stock.dart';
import 'package:flutter_application_111_copy/Offiice/office_student.dart';
import 'package:flutter_application_111_copy/firebase_options.dart';
import 'package:flutter_application_111_copy/Auth/home_screen.dart';
import 'package:flutter_application_111_copy/splash_screen.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/signup': (context) => SignUpScreen(), // Create SignUpPage separately
        '/signin': (context) => LoginScreen(),
        '/splash': (context) => SplashScreen(),
         // Create SignInPage separately
      '/home': (context) => OfficeHomePage(),
      '/staff': (context) => OfficeStaffPage(),
      '/nonStaff': (context) => OfficeNonStaffPage(),
      '/feeDetails': (context) => OfficeStudentFee(),
      '/stock': (context) => OfficeStockPage(),
      },
      
    );
  }
}