import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_111_copy/signin_scree.dart';

class SignedUpScreen extends StatefulWidget {
  const SignedUpScreen({super.key});

  @override
  State<SignedUpScreen> createState() => _SignedUpScreenState();
}

class _SignedUpScreenState extends State<SignedUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
     String? _email = _auth.currentUser!.email;
    return Scaffold(
      appBar: AppBar(
        title: Text("You Are In"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Registered Successfully with: $_email"),
              SizedBox(height: 50,),
               ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                      context, MaterialPageRoute(
                        builder: (ctx){
                          return LoginScreen();
                          }
                          )
                          );
        
                  }, child: Text("Sign In"),
                  
                  )
            ],
          ),),
          
        ),
      ),
    );
  }
}