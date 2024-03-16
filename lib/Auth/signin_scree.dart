import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_111_copy/Auth/signup_screen.dart';
import 'package:flutter_application_111_copy/Auth/welcome.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  String _email = "";
  String _password = "";

  void _handleLogin() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      print("User Logged In : ${userCredential.user!.email}");
      // Redirect to WelcomePage
      Navigator.push(
        context,
        MaterialPageRoute(builder: (ctx) {
          return WelcomePage();
        }),
      );
    } catch (e) {
      print("Error During logged In : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          Positioned(
            width: MediaQuery.of(context).size.width,
            bottom: 35,
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                "assets/images/login.png",
                height: 400,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Hello Again
                Text(
                  "Hello Again",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Welcome Back you've been missed!",
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
                                labelText: "Email"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter Your Email";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _email = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                            controller: _passController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Password"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter Your Password";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _password = value;
                              });
                            }),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              _handleLogin();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.green,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 30),
                          ),
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        // Text for sign up
                        GestureDetector(
                          onTap: () {
                            // Navigate to SignUpScreen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Don't have an account yet? Sign up",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
