import 'dart:ui';

import 'package:HauntedHallows/HomeView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('UserData');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
          
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeView()));
        }),
        elevation: 0,
        centerTitle: true,
        title: Text("Profile"),
        backgroundColor: Colors.yellow[800],
      ),
      backgroundColor: Color.fromRGBO(255, 183, 45, 1),
      body: Container(
        decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage("https://i.imgur.com/d0rz0dn.png"),
                  fit: BoxFit.cover)),
        child: FutureBuilder<DocumentSnapshot>(
          future: users.doc("${auth.currentUser.uid}").get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }
            //data['Cash']
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data = snapshot.data.data();
              return Column(
                children: [
                  SizedBox(height: 40,),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.yellow[800],
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.yellow[700],width: 10)
                      ),
                      height: 220,
                      width: 220,
                    ),
                  ),
                  SizedBox(height: 60,),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        child: Row(
                          children: [
                            SizedBox(width: 20,),
                            Text("Character:",style: TextStyle(color: Colors.orange[200],fontSize: 22,fontWeight: FontWeight.w700),),
                            Spacer(),
                            Text(data["Character"],style: TextStyle(color: Colors.grey[100],fontSize: 22,fontWeight: FontWeight.w700),),
                            SizedBox(width: 20,),
                            
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange[400],
                          border: Border.all(color: Colors.yellow[700],width: 10)
                        ),
                        height: 80,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        child: Row(
                          children: [
                            SizedBox(width: 20,),
                            Text("User ID:",style: TextStyle(color: Colors.orange[200],fontSize: 22,fontWeight: FontWeight.w700),),
                            Spacer(),
                            Text(data["UserUID"],style: TextStyle(color: Colors.grey[100],fontSize: 22,fontWeight: FontWeight.w700),),
                            SizedBox(width: 20,),
                            
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange[400],
                          border: Border.all(color: Colors.yellow[700],width: 10)
                        ),
                        height: 80,
                      ),
                    ),
                  ),
                ],
              );
            }

            return Text("loading");
          },
        ),
      ),
    );
  }
}
