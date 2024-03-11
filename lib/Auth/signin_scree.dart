import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_111_copy/Auth/welcome.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formkey =GlobalKey<FormState>();
  TextEditingController _emailController =TextEditingController();
  TextEditingController _passController =TextEditingController();

  String _email = "";
  String _password = "";
  void _handleLogin()async{
    try{
      UserCredential userCredential = 
      await _auth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
        );
        print("User Logged In : ${userCredential.user!.email}");
        Navigator.push(
                    context, MaterialPageRoute(
                      builder: (ctx){
                        return WelcomePage();
                        }
                        )
                        );
    }catch(e){
      print("Error During logged In : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text("Login"),
      ),

      body: Center(
        child: Column(
          children: [
            SizedBox(height: 25,),
            //Hello Again
            Text(
              "Hello Again",
               style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                ),
              ),

              SizedBox(height: 10,),
            
            Text(
              "Welcome Back you\'ve been missed!",
               style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                ),
              ),
            
            
            
            Padding(
              padding: EdgeInsets.all(16),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Email"
                      ),
                      
                      
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "Please Enter Your Email";
                        }
                        return null;
                      },
                      onChanged: (value){
                        setState((){ _email=value;});
                      }
                    ),
                  ),
            
                  SizedBox(height: 20),
            
                  TextFormField(
                    controller: _passController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(  
                      border: OutlineInputBorder(),
                      labelText: "Password"
                    ),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Please Enter Your Password";
                      }
                      return null;
                    },
                    onChanged: (value){
                      setState((){ _password=value;});
                    }
                  ),
                  SizedBox(height: 20,),
            
                  ElevatedButton(
                    onPressed: (){
                      if (_formkey.currentState!.validate()){
                        _handleLogin();
                      }
            
                    }, child: 
                    Text("Login")
                    )
                ],
                ),
                )
              ),
          ],
        ),
      ),
    );
  }
}