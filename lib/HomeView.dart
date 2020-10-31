import 'dart:ui';
import 'package:HauntedHallows/scanObject.dart';
import 'package:HauntedHallows/screens/profileview.dart';
import 'package:HauntedHallows/screens/quests.dart';
import 'package:HauntedHallows/screens/social.dart';
import 'package:HauntedHallows/screens/spellslist.dart';
import 'package:HauntedHallows/screens/storeview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

import 'package:percent_indicator/linear_percent_indicator.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<void> updateCharacter(String name) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('UserData');
    // Call the user's CollectionReference to add a new user
    return users
        .doc("${auth.currentUser.uid}")
        .update({
          'Character': name,
        })
        .then((value) => print("Character Updated"))
        .catchError((error) => print("Failed to add Character: $error"));
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('UserData')
              .doc('${auth.currentUser.uid}')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            var userDocument = snapshot.data;
            if (userDocument["Character"] == "None") {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      'Pick Character',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  FlipCard(
                    direction: FlipDirection.VERTICAL, // default
                    front: Container(
                      child: Container(
                        height: 190,
                        width: 290,
                        child: Image(
                            image: NetworkImage(
                                'https://i.imgur.com/jh30biz.png')),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.pink[200], width: 10),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.pink[100],
                        ),
                      ),
                    ),
                    back: Container(
                      child: Container(
                        height: 190,
                        width: 290,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Fire Wizard',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Center(
                                  child: Text(
                                'HEOG ogheo ghoiwgh oieahg hgfoeish soghs oeghsoiehg',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              )),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    updateCharacter('Fire Wizard');
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.pink[200],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                        child: Text(
                                      'Choose',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500),
                                    )),
                                    height: 45,
                                    width: 140,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.pink[200], width: 10),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.pink[100],
                        ),
                      ),
                    ),
                  ),
                  FlipCard(
                    direction: FlipDirection.VERTICAL, // default
                    front: Container(
                      height: 190,
                      width: 290,
                      child: Image(
                          image:
                              NetworkImage('https://i.imgur.com/gMoY7aU.png')),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue[200], width: 10),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue[100],
                      ),
                    ),
                    back: Container(
                      child: Container(
                        height: 190,
                        width: 290,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Ice Mage',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Center(
                                  child: Text(
                                'HEOG ogheo ghoiwgh oieahg hgfoeish soghs oeghsoiehg',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              )),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    updateCharacter('Ice Mage');
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blue[200],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                        child: Text(
                                      'Choose',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500),
                                    )),
                                    height: 45,
                                    width: 140,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.blue[200], width: 10),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue[100],
                        ),
                      ),
                    ),
                  ),
                  FlipCard(
                    direction: FlipDirection.VERTICAL, // default
                    front: Container(
                      height: 190,
                      width: 290,
                      child: Image(
                          image:
                              NetworkImage('https://i.imgur.com/PrSOd7r.png')),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.orange[200], width: 10),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.orange[100],
                      ),
                    ),
                    back: Container(
                      child: Container(
                        height: 190,
                        width: 290,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Sand Surfer',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Center(
                                  child: Text(
                                'HEOG ogheo ghoiwgh oieahg hgfoeish soghs oeghsoiehg',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              )),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    updateCharacter('Sand Surfer');
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.orange[200],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                        child: Text(
                                      'Choose',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500),
                                    )),
                                    height: 45,
                                    width: 140,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.orange[200], width: 10),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.orange[100],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0,
                  ),
                ],
              );
            } else {
              return Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage("https://i.imgur.com/R3QSwPz.png"),
                        fit: BoxFit.cover)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 70.0,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              userDocument["UserName"],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 24.0,
                              ),
                            ),
                            Spacer(),
                            Text(
                              userDocument["Cash"].toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18.0,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Candy",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18.0,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                        decoration: new BoxDecoration(
                            color: Colors.purple[800],
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: GridView.count(
                        primary: false,
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        crossAxisCount: 2,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          StoreView()));
                            },
                            child: Stack(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 0, right: 0),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "🛍️",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 50),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          const Text(
                                            "Store",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 34),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SpellsList(userDocument["Level"])));
                            },
                            child: Stack(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 0, right: 0),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "🧪",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 50),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          const Text(
                                            "Spells",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 34),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          QuestView()));
                            },
                            child: Stack(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 0, right: 0),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "📜",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 50),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          const Text(
                                            "Quests",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 34),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              print('Pass');
                            },
                            child: Stack(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, right: 10),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "🎉",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 50),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          const Text(
                                            "Events",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 34),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    child: Center(
                                        child: Text(
                                      "${userDocument["Event Alerts"]}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
                                    )),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SocialView()));
                            },
                            child: Stack(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, right: 10),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "🧑‍🤝‍🧑",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 50),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          const Text(
                                            "Social",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 34),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    child: Center(
                                        child: Text(
                                      "${userDocument["Social Alerts"]}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
                                    )),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProfileView()));
                            },
                            child: Stack(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 0, right: 0),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "🧍",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 50),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          const Text(
                                            "Profile",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 34),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 135.0,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(userDocument["XP"].toString()),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text("XP"),
                                        SizedBox(
                                          width: 7,
                                        ),
                                        Expanded(
                                          child: LinearPercentIndicator(
                                            lineHeight: 15.0,
                                            percent: userDocument["XP"] / 100,
                                            progressColor: Colors.purple[300],
                                            backgroundColor: Colors.grey[900],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 170,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("Spells Complete:"),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text("${userDocument["Spells Complete"]}"),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                      height: 50,
                                      width: 170,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text('Character Level:'),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text("${userDocument["Level"]}"),
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                        decoration: new BoxDecoration(
                            color: Colors.purple[800],
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}
