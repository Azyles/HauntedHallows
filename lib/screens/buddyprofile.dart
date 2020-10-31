import 'dart:ui';

import 'package:HauntedHallows/HomeView.dart';
import 'package:HauntedHallows/auth/registerview.dart';
import 'package:HauntedHallows/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BuddyProfileView extends StatefulWidget {
  final String buddyname;

  BuddyProfileView(this.buddyname, {Key, key}) : super(key: key);
  @override
  _BuddyProfileViewState createState() => _BuddyProfileViewState();
}

class _BuddyProfileViewState extends State<BuddyProfileView> {

  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('UserData');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomeView()));
            }),
        elevation: 0,
        centerTitle: true,
        title: Text("Profile"),
        backgroundColor: Colors.purple[800],
      ),
      backgroundColor: Colors.purple[800],
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage("https://i.imgur.com/R3QSwPz.png"),
                fit: BoxFit.cover)),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
                  .collection('UserData')
                  .where("UserUID", isEqualTo: widget.buddyname)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                    'Something went wrong',
                    style: TextStyle(color: Colors.black),
                  ));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Expanded(
                  child: new ListView(
                    // ignore: deprecated_member_use
                    children:
                        snapshot.data.docs.map((DocumentSnapshot document) {
                      if (document.data() == null) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Container(
                      child: Center(
                          child: Text(":)")),
                      decoration: BoxDecoration(
                          color: Colors.grey[900],
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: Colors.purple[700], width: 10)),
                      height: 220,
                      width: 220,
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Name:",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700),
                            ),
                            Spacer(),
                            Text(
                              document.data()['UserName'],
                              style: TextStyle(
                                  color: Colors.grey[100],
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.purple[800],
                            border: Border.all(
                                color: Colors.purple[700], width: 10)),
                        height: 80,
                      ),
                    ),
                  ),
                  
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Character:",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700),
                            ),
                            Spacer(),
                            Text(
                              document.data()["Character"],
                              style: TextStyle(
                                  color: Colors.grey[100],
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.purple[800],
                            border: Border.all(
                                color: Colors.purple[700], width: 10)),
                        height: 80,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Level:",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700),
                            ),
                            Spacer(),
                            Text(
                              document.data()["Level"].toString(),
                              style: TextStyle(
                                  color: Colors.grey[100],
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.purple[800],
                            border: Border.all(
                                color: Colors.purple[700], width: 10)),
                        height: 80,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Spells Complete:",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700),
                            ),
                            Spacer(),
                            Text(
                              document.data()["Spells Complete"].toString(),
                              style: TextStyle(
                                  color: Colors.grey[100],
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.purple[800],
                            border: Border.all(
                                color: Colors.purple[700], width: 10)),
                        height: 80,
                      ),
                    ),
                  ),     
                ],
              );
                      }
                    }).toList(),
                  ),
                );
              },
            ),
      ),
    );
  }
}


/*
Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Container(
                      child: Center(
                          child: Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.grey[800],
                        size: 60,
                      )),
                      decoration: BoxDecoration(
                          color: Colors.grey[900],
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: Colors.purple[700], width: 10)),
                      height: 220,
                      width: 220,
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Character:",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700),
                            ),
                            Spacer(),
                            Text(
                              document.data()['UserUID'],
                              style: TextStyle(
                                  color: Colors.grey[100],
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.purple[800],
                            border: Border.all(
                                color: Colors.purple[700], width: 10)),
                        height: 80,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "User ID:",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700),
                            ),
                            Spacer(),
                            Text(
                              data["UserUID"],
                              style: TextStyle(
                                  color: Colors.grey[100],
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.purple[800],
                            border: Border.all(
                                color: Colors.purple[700], width: 10)),
                        height: 80,
                      ),
                    ),
                  ),     
                ],
              );*/