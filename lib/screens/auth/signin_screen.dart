import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/auth/signup_screen.dart';
import 'package:news_app/utils/util.dart';
import 'package:news_app/utils/validation.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  FirebaseAuth _auth=FirebaseAuth.instance;

  final _formKey=GlobalKey<FormState>();
  final _emailControllerSignIn=TextEditingController();
  final _passwordControllerSignIn=TextEditingController();

  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 250,
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
              children: [
                   TextFormField(
                    validator:(value) {
                      return Validation.validateMail(value!);
                    },
                    controller:_emailControllerSignIn,
                    decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        
                        borderRadius: BorderRadius.circular(15),
                      )
                    ),
                   ),
                   SizedBox(
                    height: 10,
                   ),
                    TextFormField(
                    controller:_passwordControllerSignIn,
                      validator:(value){
                      return Validation.validatePassword(value!);
                    },
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(Icons.password),
                      border: OutlineInputBorder(
                        
                        borderRadius: BorderRadius.circular(15),
                      )
                    ),
                   ),

                   SizedBox(
                    height: 50,
                   ),

                   InkWell(
                    onTap: () {
                      if(_formKey.currentState!.validate()){
                             isSignIn();
                      }
                    },
                     child: Container(
                      height: 55,
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: isLoading ? CircularProgressIndicator(color: Colors.white,): Text('SignIn',style: TextStyle(color: Colors.white),),
                      ),
                     ),
                   ),
                   TextButton(onPressed:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
                   }, child: Text("You have not account?")),
              ],
            )),
          ),

        ],
      ),
    );
  }


  void isSignIn(){
    setState((){
      isLoading=true;
    });
         _auth.signInWithEmailAndPassword(
                                email: _emailControllerSignIn.text.toString(),
                                 password: _passwordControllerSignIn.text.toString(),
                                 ).then((value){
                                  setState(() {
                                    isLoading=false;
                                  });
                                     Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                                 }).onError((error,StackTrace){
                                  Utils().toastMsg(error.toString());
                                  setState(() {
                                    isLoading=false;
                                  });
                                 });
  }

}