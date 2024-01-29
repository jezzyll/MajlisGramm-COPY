import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_111_copy/Auth/majlisgram_home.dart';
import 'package:flutter_application_111_copy/Auth/signin_scree.dart';


class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    String? _email = _auth.currentUser!.email;
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard"),),
      body: Center(
        child: Padding(padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Logged In with: $_email"),
            SizedBox(height: 50,),
             ElevatedButton(
                onPressed: (){
                  _auth.signOut();
                  Navigator.push(
                    context, MaterialPageRoute(
                      builder: (ctx){
                        return LoginScreen();
                        }
                        )
                        );

                }, child: Text("Sign Out"),
                
                ),
                SizedBox(height: 60,),
                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (ctx){return MajlisgramHome();}));
                }, child: Text("Let's Go"))
          ],
        ),),

        
      ),
      
    );
  }
}