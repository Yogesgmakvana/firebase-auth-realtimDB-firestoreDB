import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/auth/signin_screen.dart';
import 'package:news_app/screens/auth/signup_screen.dart';

class Splashservices {

  void isLogin(BuildContext context)async{
    // final auth=FirebaseAuth.instance;
    // final user=auth.currentUser;
    final auth=FirebaseAuth.instance;
    final user=auth.currentUser;


    if (user != null) {
      await Future.delayed(Duration(seconds: 3),(){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeScreen()));
      });
    }else{
      await Future.delayed(Duration(seconds: 3),(){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>SignupScreen()));
      });
    }
  }
}

