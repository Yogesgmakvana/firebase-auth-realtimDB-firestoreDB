import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/screens/auth/verify_code.dart';
import 'package:news_app/utils/util.dart';

class LoginWithMobile extends StatefulWidget {
  const LoginWithMobile({super.key});

  @override
  State<LoginWithMobile> createState() => _LoginWithMobileState();
}

class _LoginWithMobileState extends State<LoginWithMobile> {
  final _formKey=GlobalKey<FormState>();
  final _mobileController=TextEditingController();
  bool isLoading=false;
  final _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 200,
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _mobileController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.call),
                  hintText: "+91 **********",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  )
                ),
              ),
              SizedBox(
                height: 50,
              ),


              InkWell(
                    onTap: () {
                      _auth.verifyPhoneNumber(
                        phoneNumber:_mobileController.text,
                        verificationCompleted:(_){

                        }, 
                        verificationFailed:(e){
                          Utils().toastMsg(e.toString());
                        }, 
                        codeSent:(String verification, int? tocken){
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifyCode(id:verification)));
                        } ,
                        codeAutoRetrievalTimeout: (e){
                          Utils().toastMsg(e.toString());
                        },
                        );
                     
                      
                    },
                     child: Container(
                      height: 55,
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: isLoading ? CircularProgressIndicator(color: Colors.white,): Text('Send Code',style: TextStyle(color: Colors.white),),
                      ),
                     ),
                   ),
                   TextButton(onPressed:() {
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifyCode()));
                   }, child: Text('Verify Screen'))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}