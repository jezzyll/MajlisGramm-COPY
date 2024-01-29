import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_111_copy/Auth/signedup_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formkey =GlobalKey<FormState>();
  TextEditingController _emailController =TextEditingController();
  TextEditingController _passController =TextEditingController();
  TextEditingController _nameController =TextEditingController();
  TextEditingController _ageController =TextEditingController();
  TextEditingController _bloodController =TextEditingController();


  String _email = "";
  String _password = "";
  String _name = "";
  String _age = "";
  String _blood = "";
  void _handleSignUp()async{


    //authenticate User
    try{
      UserCredential userCredential = 
      await _auth.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
        );
        print("User Registered : ${userCredential.user!.email}");
        if (userCredential.user != null) {

          addUserDetails(
            _nameController.text.trim(),
            _emailController.text.trim(),
            int.parse(_ageController.text.trim()),
            _bloodController.text.trim(),

          );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SignedUpScreen(),
          ),
        );
      }
    }catch(e){
      print("Error During Registration : $e");
    }
  }

  Future addUserDetails(String name,String email,int age,String blood) async {
    await FirebaseFirestore.instance.collection('users').add({
      'name':name ,
      'email':email ,
      'age':age ,
      'blood':blood ,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),



      body: Center(       
        child: Padding(
          padding: EdgeInsets.all(16),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //name-section

              TextFormField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Name"
                ),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Please Enter Your Name";
                  }
                  return null;
                },
                onChanged: (value){
                  setState((){ _name=value;});
                }
              ),

              SizedBox(height: 20),

              //email-section

              TextFormField(
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

              SizedBox(height: 20),

              //password-section

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

              //age-section

              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Age"
                ),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Please Enter Your Age";
                  }
                  return null;
                },
                onChanged: (value){
                  setState((){ _age=value;});
                }
              ),

              SizedBox(height: 20),

              //blood-section

              TextFormField(
                controller: _bloodController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Blood Group"
                ),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Please Type Your Blood Group";
                  }
                  return null;
                },
                onChanged: (value){
                  setState((){ _blood=value;});
                }
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: (){
                  if (_formkey.currentState!.validate()){
                    _handleSignUp();
                  }

                }, child: 
                Text("Sign Up")
                )
            ],
            ),
            )
          ),
      ),
    );
  }
}