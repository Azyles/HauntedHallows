import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class QuestView extends StatefulWidget {
  @override
  _QuestViewState createState() => _QuestViewState();
}

class _QuestViewState extends State<QuestView> {
  FirebaseAuth auth = FirebaseAuth.instance;
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

          int newSpellTotalCount = snapshot.data()['newSpellTotalCount'] - 10;

          transaction.update(documentReference,
              {'Cash': newCandyCount, 'Spells Complete': newSpellTotalCount});

          return newCandyCount;
        })
        .then((value) => print("XP count updated to $value"))
        .catchError((error) => print("Failed to update user XPs: $error"));
  }

  CollectionReference users = FirebaseFirestore.instance.collection('UserData');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.purple[800],
      ),
      backgroundColor: Colors.purple[800],
      body: FutureBuilder<DocumentSnapshot>(
        future: users.doc('${auth.currentUser.uid}').get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Container(color: Colors.black ,child: Center(child: Text("Something went wrong")));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data();
            if (data["Level"] > 1) {
              return Container(
                decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage("https://i.imgur.com/R3QSwPz.png"),
                fit: BoxFit.cover)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              if (data["Spells Complete"] > 10) {
                                addCash();
                              } else {
                                final snackBar = SnackBar(
                                  backgroundColor: Colors.deepPurple[500],
                                  content: Text(
                                    "Make more spells!",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  action: SnackBarAction(
                                    label: 'Ok',
                                    textColor: Colors.white,
                                    onPressed: () {
                                      // Some code to undo the change.
                                    },
                                  ),
                                );

                                // Find the Scaffold in the widget tree and use
                                // it to show a SnackBar.
                                Scaffold.of(context).showSnackBar(snackBar);
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20, top: 15),
                                        child: Text(
                                          "Spell Master!",
                                          style: TextStyle(
                                              fontSize: 21,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20, top: 15),
                                        child: Text(
                                          data["Spells Complete"].toString(),
                                          style: TextStyle(
                                              color: Colors.grey[700],
                                              fontSize: 21,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 20, top: 15),
                                    child: Text(
                                      "A good wizard is one that has experience. Make 10 spells and in return you will be awarded candy!",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20, top: 15, bottom: 15),
                                    child: Expanded(
                                      child: LinearPercentIndicator(
                                        lineHeight: 15.0,
                                        percent: data["Spells Complete"] / 10,
                                        progressColor: Colors.blue[200],
                                        backgroundColor: Colors.grey[800],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[900],
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              if (data["Spells Complete"] > 10) {
                                addCash();
                              } else {
                                final snackBar = SnackBar(
                                  backgroundColor: Colors.deepPurple[500],
                                  content: Text(
                                    "Make more friends!",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  action: SnackBarAction(
                                    label: 'Ok',
                                    textColor: Colors.white,
                                    onPressed: () {
                                      // Some code to undo the change.
                                    },
                                  ),
                                );

                                // Find the Scaffold in the widget tree and use
                                // it to show a SnackBar.
                                Scaffold.of(context).showSnackBar(snackBar);
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20, top: 15),
                                        child: Text(
                                          "Friendly Wizard!",
                                          style: TextStyle(
                                              fontSize: 21,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20, top: 15),
                                        child: Text(
                                          "1",
                                          style: TextStyle(
                                            color: Colors.grey[700],
                                              fontSize: 21,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 20, top: 15),
                                    child: Text(
                                      "You know whats better than one wizard? Two Wizards. Make 5 friends and in return you will be awarded a badge!",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20, top: 15, bottom: 15),
                                    child: Expanded(
                                      child: LinearPercentIndicator(
                                        lineHeight: 15.0,
                                        percent: 1 / 10,
                                        progressColor: Colors.blue[200],
                                        backgroundColor: Colors.grey[800],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[900],
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Container(
                color: Colors.black,
                child: Center(
                  child: Text("You need to be level 2 or higher to do quests"),
                ),
              );
            }
          }

          return Text("loading");
        },
      ),
    );
  }
}
