import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/utils/util.dart';

class VerifyCode extends StatefulWidget {
   VerifyCode({super.key,this.id});
   String? id;
  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
 final _formKey=GlobalKey<FormState>();
 bool isLoading=false;
 final _codeController=TextEditingController();

 final _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                    controller: _codeController,
                decoration: InputDecoration(
                  
                  hintText: "Enter 6 digit Code",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  )
                ),
              ),
              SizedBox(
                height: 50,
              ),


              InkWell(
                    onTap: ()async {
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                    //  final creditials=PhoneAuthProvider.credential(
                    //   verificationId:widget.id.toString() , 
                    //   smsCode:_codeController.text);


                    //   try {
                    //     await _auth.signInWithCredential(creditials);
                    //      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                    //   } catch (e) {
                      
                    //     Utils().toastMsg(e);
                    //   }
                      
                    },
                     child: Container(
                      height: 55,
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: isLoading ? CircularProgressIndicator(color: Colors.white,): Text('Login',style: TextStyle(color: Colors.white),),
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
}