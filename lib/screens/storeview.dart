import 'package:HauntedHallows/HomeView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StoreView extends StatefulWidget {
  @override
  _StoreViewState createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
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
        title: Text("Store"),
        backgroundColor: Colors.purple[800],
      ),
      backgroundColor: Colors.purple[800],
      body: Container(
        decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage("https://i.imgur.com/R3QSwPz.png"),
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
                  Center(
                    child: Text("TEST"),
                  )
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
