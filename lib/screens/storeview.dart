import 'dart:ui';

import 'package:HauntedHallows/HomeView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class StoreView extends StatefulWidget {
  @override
  _StoreViewState createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  Future<void> resetspell(String spellname) async {
    CollectionReference users = FirebaseFirestore.instance
        .collection('UserData')
        .doc("${auth.currentUser.uid}")
        .collection("Spells");
    // Call the user's CollectionReference to add a new user

    return users
        .doc(spellname)
        .set({
          'Name': "${spellname}",
          'Created': false,
          'Quality': 0,
          'LevelNeeded': 0,
          '1': [
            {
              'Name': 'Silky cloth from Spooky Spiders',
              'Label': 'Insect',
              'Own': false,
              'Rarity': 0
            }
          ],
          '2': [
            {
              'Name': 'Pointy Pine Cones from the Haunted Forest',
              'Label': 'Branch',
              'Own': false,
              'Rarity': 0
            }
          ],
          '3': [
            {
              'Name': 'Fur of Cheshire cat',
              'Label': 'Cat',
              'Own': false,
              'Rarity': 0
            }
          ],
          '4': [
            {
              'Name': 'The Fang of the Basilisk Serpentine',
              'Label': 'Toy',
              'Own': false,
              'Rarity': 0
            }
          ],
          '5': [
            {
              'Name': 'The Eyeballs of Dracula.',
              'Label': 'Eyelash',
              'Own': false,
              'Rarity': 0
            }
          ],
          '6': [
            {
              'Name': 'Branch of the old, wise oak',
              'Label': 'Branch',
              'Own': false,
              'Rarity': 0
            }
          ],
        })
        .then((value) => print("Updated"))
        .catchError((error) => print("Failed to update item: $error"));
  }

  Future<void> addCash() {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('UserData')
        .doc("${auth.currentUser.uid}");

    return FirebaseFirestore.instance
        .runTransaction((transaction) async {
          // Get the document
          DocumentSnapshot snapshot = await transaction.get(documentReference);

          if (!snapshot.exists) {
            throw Exception("User does not exist!");
          }

          var cashgiven = 20;

          int newCandyCount = snapshot.data()['Cash'] + cashgiven;

          transaction.update(documentReference, {'Cash': newCandyCount});

          return newCandyCount;
        })
        .then((value) => print("XP count updated to $value"))
        .catchError((error) => print("Failed to update user XPs: $error"));
  }

  CollectionReference users = FirebaseFirestore.instance.collection('UserData');
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomeView()));
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
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        child: DragTarget(
                          builder: (context, List<String> candidateData,
                              rejectedData) {
                            print(candidateData);
                            return Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 100),
                                  child: Text(
                              "",
                              style: TextStyle(
                                    color: Colors.black, fontSize: 26.0,fontWeight: FontWeight.w700,backgroundColor: Colors.white),
                            ),
                                ));
                          },
                          onWillAccept: (data) {
                            return true;
                          },
                          onAccept: (data) {
                            print(data);
                            resetspell(data);
                            addCash();
                            print("Item Sold.");
                          },
                        ),
                        decoration: BoxDecoration(
                          image: DecorationImage(image: NetworkImage("https://cdn.dribbble.com/users/205777/screenshots/7735680/media/2085b6952c8d6899f0544719e20bdb08.png"),fit: BoxFit.fitWidth),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        height: 170,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('UserData')
                        .doc("${auth.currentUser.uid}")
                        .collection('Spells')
                        .where("Created", isEqualTo: true)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading");
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: new GridView(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20),
                          children: snapshot.data.docs
                              .map((DocumentSnapshot document) {
                            return Draggable(
                              data: "${document.data()['Name']}",
                              feedback: Container(
                                height: 175,
                                width: 175,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Center(
                                      child: new Text(
                                    document.data()['Name'],
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                  )),
                                ),
                              ),
                              child: new Container(
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Center(
                                      child: new Text(
                                    document.data()['Name'],
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                  )),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ))
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
