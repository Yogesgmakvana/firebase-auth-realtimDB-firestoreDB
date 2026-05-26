import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/screens/auth/Login_with_mobile.dart';
import 'package:news_app/screens/auth/signin_screen.dart';
import 'package:news_app/utils/util.dart';
import 'package:news_app/utils/validation.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 250),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      return Validation.validateMail(value!);
                    },
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _passwordController,
                    validator: (value) {
                      Validation.validatePassword(value!);
                    },
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(Icons.password),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),

                  SizedBox(height: 50),

                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        signUp();
                      }
                    },
                    child: Container(
                      height: 55,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child:isLoading? CircularProgressIndicator(color: Colors.white,): Text(
                          'SignUp',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                 
                 
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SigninScreen()),
                      );
                    },
                    child: Text('Alreay have?'),
                  ),
                   SizedBox(
                    height: 15,
                  ),
                   InkWell(
                    onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginWithMobile()));
                    },
                    child: Container(
                      height: 55,
                      width: 300,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child:isLoading? CircularProgressIndicator(color: Colors.white,): Text(
                          'Login With Mobile',
                          style: TextStyle(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void signUp() {
    setState(() {
      isLoading = true;
    });
    _auth.createUserWithEmailAndPassword(
          email: _emailController.text.toString(),
          password: _passwordController.text.toString(),
        )
        .then((value) {
          setState(() {
            isLoading = false;
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SigninScreen()),
          );
        })
        .onError((error, StackTrace) {
          Utils().toastMsg(error.toString());
           setState(() {
      isLoading=false;
    });
        });
  }
}
