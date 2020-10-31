import 'package:HauntedHallows/screens/buddyprofile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../HomeView.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class SocialView extends StatefulWidget {
  @override
  _SocialViewState createState() => _SocialViewState();
}

class _SocialViewState extends State<SocialView> {
  String userid = '';
  final TextEditingController _useridController = TextEditingController();
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
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.purple[800],
                        borderRadius: BorderRadius.circular(15)),
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: TextFormField(
                                style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 19),
                                controller: _useridController,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 19),
                                    border: InputBorder.none,
                                    hintText: 'Search ID'),
                                validator: (value) {
                                  if (value == null || value == '') {
                                    return 'UserName cannot be blank';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {
                                setState(() {
                                  userid = _useridController.text;
                                });
                              })
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('UserData')
                  .where("UserName", isEqualTo: userid)
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
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BuddyProfileView(document.data()['UserUID'])));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(15)),
                                  height: 60,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          document.data()['UserName'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          document.data()['UserUID'].toString(),
                                          style: TextStyle(
                                              color: Colors.grey[900],
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    }).toList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
