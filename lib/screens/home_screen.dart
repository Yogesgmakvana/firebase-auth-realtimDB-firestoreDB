import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:news_app/screens/addData_screen.dart';
import 'package:news_app/screens/auth/signin_screen.dart';
import 'package:news_app/utils/util.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _auth=FirebaseAuth.instance;
  final firebase_ref=FirebaseDatabase.instance.ref('post');
  final _searchController=TextEditingController();
  final _editController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed:() {
         Navigator.push(context, MaterialPageRoute(builder: (context)=>AdddataScreen()));
      },),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed:() {
            _auth.signOut().then((value){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SigninScreen()));
            }).onError((error,StackTrace){
                  Utils().toastMsg(error.toString());
            });
          }, icon: Icon(Icons.logout))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search Bar",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  )
                ),
                onChanged: (value) {
                  setState(() {
                    
                  });
                },
              ),
            ),
             Expanded(child:
           FirebaseAnimatedList(
            defaultChild: Center(child: CircularProgressIndicator(strokeWidth: 50,),),
            query: firebase_ref, 
            itemBuilder: (context ,snapshot,animation, index){
              final title=snapshot.child('title').value.toString();
              if (_searchController.text.isEmpty) {
                 return ListTile(
                  title: Text(snapshot.child('title').value.toString()),
                  leading:CircleAvatar(child: Center(child: Text('${index+1}'),),),
                  subtitle: Text(snapshot.child('id').value.toString()),
                  trailing: PopupMenuButton(
                    itemBuilder: (context)=>[
                     PopupMenuItem(
                      value: 1,
                      child: ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          showUpdateDialog(context,title,snapshot.child('id').value.toString());
                        },
                        title: Text('Edit'),
                        trailing: Icon(Icons.edit),
                      )),
                      
                      PopupMenuItem(
                      value: 2,
                      onTap: () {
                        
                       deleteDialog(context,snapshot.child('id').value.toString());
                      },
                      child: ListTile(
                        title: Text('Delete'),
                        trailing: Icon(Icons.delete),
                      )),


                  ]),
                );
              }else if(title.toLowerCase().contains(_searchController.text.toLowerCase().toString())){
                    return ListTile(
                  title: Text(snapshot.child('title').value.toString()),
                  subtitle: Text(snapshot.child('id').value.toString()),
                );
              }else{
                return Container();
              }
               
            }) ),
          
          ],
        ),
      ),
    );
  }

  Future<void>showUpdateDialog(BuildContext context,String title,String id)async{
    _editController.text = title;
    return showDialog(
      context:context ,
       builder: (context){
        return AlertDialog(
          title: Text('Update Data'),
          content: Container(
            child:TextField(
              controller: _editController,
              decoration: InputDecoration(
                hintText: "Enter Value",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                )
              ),
            ),
          ),
          actions: [
            //cancel button
              TextButton(onPressed:() {
                 Navigator.pop(context);
              }, child: Text('Cancel')),
                 //update button
                TextButton(onPressed:() {
                 Navigator.pop(context);
                 firebase_ref.child(id).update({
                  'title':_editController.text.toLowerCase(),
                 }).then((value) {
                   
                 },).onError((error,trackTrace){
                   Utils().toastMsg(error.toString());
                 });
              }, child: Text('Update')),
          ],
        );
       }
       );
  }


  Future<void>deleteDialog(BuildContext context,id)async{
    return showDialog(context: context, builder: (context){
      return AlertDialog(
             title: Text('Are you wanna Delete?'),
             actions: [
              TextButton(onPressed:() {
                Navigator.pop(context);
              }, child: Text('cancel')),

                TextButton(onPressed:() {
                Navigator.pop(context);
                firebase_ref.child(id).remove();
              }, child: Text('Delete')),
             ],
      );
    });
  }
}

// Expanded(child: StreamBuilder(
//           stream:firebase_ref.onValue,
//            builder: (context,AsyncSnapshot<DatabaseEvent>snapshot){
//             if(!snapshot.hasData){
//                  return Center(child: CircularProgressIndicator(),);
//                }else{
//                 Map<dynamic,dynamic>map=snapshot.data!.snapshot.value as dynamic;
//                 List<dynamic>list=[];
//                 list.clear();
//                   list=map.values.toList();
//                  return ListView.builder(
//               itemCount: snapshot.data!.snapshot.children.length,
//               itemBuilder:(context,index){
//                  return Card(
//                    child: ListTile(
//                     title: Text(list[index]['title']),
//                     leading: CircleAvatar(child: Text(list[index]['id'])),
//                    ),
//                  );
//               } );
//                }
//   },),),