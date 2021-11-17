import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ChatPage.dart';
import 'logInPage.dart';

class HomePage extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // bool iswriting = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          InkWell(
              onTap: (){
                FirebaseAuth.instance.signOut();
                Navigator.push(context, MaterialPageRoute(builder: (context) => logInPage()));

              },
              child: Icon(Icons.logout)),

        ],
      ),

      body: Container(
        // color: Colors.blueAccent,
        child:
        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
                .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapShot) {
            return ListView.builder(
                itemBuilder: (cxt, index)
                {
                  
                  var ds = snapShot.data.docs[index].id;
                  return Column(
                    children: [
                      snapShot.data.docs[index]['uid'] == FirebaseAuth.instance.currentUser.uid?
                          SizedBox()
                      :

                      Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.account_circle_outlined),
                            title: Text(snapShot.data.docs[index]['name']),
                            trailing: InkWell(
                              child: Icon(Icons.mail, color: Colors.red,),
                              onTap: (){

                                Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(ds)));

                              },
                            ),
                          ),
                          SizedBox(height: 5.0,),
                          Divider(thickness: 2.0,),
                        ],
                      ),

                    ],
                  );
                },
              itemCount: snapShot.data == null ? 0
                  :
                  snapShot.data.docs.length,
              // itemCount: snapShot.data!.docs.length,

            );
          },
        ),
      ),
    );
  }
}
