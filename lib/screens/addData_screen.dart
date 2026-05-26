import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/utils/util.dart';

class AdddataScreen extends StatefulWidget {
  const AdddataScreen({super.key});

  @override
  State<AdddataScreen> createState() => _AdddataScreenState();
}

class _AdddataScreenState extends State<AdddataScreen> {
  final databaseRef=FirebaseDatabase.instance.ref('post');
 bool isLoading=false;
  final _dataController=TextEditingController();
  String id=DateTime.now().millisecondsSinceEpoch.toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add data Screen'),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 150,
          ),

          Padding(
            padding: const EdgeInsets.all(15),
            child: TextFormField(
              controller: _dataController,
              decoration: InputDecoration(
                hintText: "Enter Data",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                )
              ),
            ),
          ),
          SizedBox(

            height: 50,
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: InkWell(
              onTap: () {
                setState(() {
                  isLoading=true;
                });
                databaseRef.child(id).set({
                  'title':_dataController.text.toString(),
                  'id':id,
                }).then((value) {
                  Utils().toastMsg('Post Added');
                  setState(() {
                    _dataController.clear();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                  });
                   setState(() {
                  isLoading=false;
                });
                },).onError((error,stackTrace){
                  Utils().toastMsg(error.toString());
                   setState(() {
                  isLoading=false;
                });
                });
              },
              child: Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(child:isLoading ? CircularProgressIndicator(color: Colors.white,): Text('Add Data',style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),),),
              ),
            ),
          ),
        ],
      ),
    );
  }

  
}