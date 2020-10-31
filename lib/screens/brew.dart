import 'package:HauntedHallows/HomeView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:flutter/services.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class BrewView extends StatefulWidget {
  @override
  _BrewViewState createState() => _BrewViewState();
}

class _BrewViewState extends State<BrewView> {
  Future<void> addXP() {
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

          int newXPCount = snapshot.data()['XP'] + 50;

          if (snapshot.data()['XP'] > 99) {
            int newLevelCount = snapshot.data()['Level'] + 1;

            transaction.update(documentReference, {'XP': 0});
            transaction.update(documentReference, {'Level': newLevelCount});
          } else {
            transaction.update(documentReference, {'XP': newXPCount});
          }

          return newXPCount;
        })
        .then((value) => print("XP count updated to $value"))
        .catchError((error) => print("Failed to update user XPs: $error"));
  }

  Future sleep1() {
    return new Future.delayed(const Duration(seconds: 1), () => "1");
  }

  double progress = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
            //image: DecorationImage(
            //    image: NetworkImage("https://i.imgur.com/R3QSwPz.png"),
            //    fit: BoxFit.cover)
            ),
        child: Center(
          child: Container(
            height: 300,
            width: 300,
            child: GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                setState(() {
                  progress = progress + 0.05;
                });
                if (progress > 0.95) {
                  addXP();
                  sleep1();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeView()));
                }
              },
              child: LiquidCircularProgressIndicator(
                value: progress, // Defaults to 0.5.
                valueColor: AlwaysStoppedAnimation(Colors
                    .black), // Defaults to the current Theme's accentColor.
                backgroundColor: Colors.grey[
                    100], // Defaults to the current Theme's backgroundColor.
                borderColor: Colors.grey[100],
                borderWidth: 10.0,
                direction: Axis
                    .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
              ),
            ),
          ),
        ),
      ),
    );
  }
}
