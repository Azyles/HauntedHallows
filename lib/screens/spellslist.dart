import 'package:HauntedHallows/HomeView.dart';
import 'package:HauntedHallows/scanObject.dart';
import 'package:HauntedHallows/screens/brew.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class SpellsList extends StatefulWidget {
  final int userLevel;

  SpellsList(this.userLevel, {Key, key}) : super(key: key);
  @override
  _SpellsListState createState() => _SpellsListState();
}

class _SpellsListState extends State<SpellsList> {
  final Query users = FirebaseFirestore.instance
      .collection('UserData')
      .doc('${auth.currentUser.uid}')
      .collection("Spells")
      .orderBy('LevelNeeded', descending: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[800],
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomeView()));
            }),
        elevation: 0,
        centerTitle: true,
        title: Text("Spells"),
        backgroundColor: Colors.purple[800],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage("https://i.imgur.com/R3QSwPz.png"),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: StreamBuilder<QuerySnapshot>(
              stream: users.snapshots(),
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

                return new ListView(
                  // ignore: deprecated_member_use
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    if (document.data() == null) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (widget.userLevel < document.data()['LevelNeeded']) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.purple[800],
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
                                        document.data()['Name'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20),
                                      ),
                                      Icon(Icons.lock_outline,color: Colors.purple[300],)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SpellData(
                                              document.data()['Name'])));
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
                                          document.data()['Name'],
                                          style: TextStyle(
                                              color: Colors.white,
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
                    }
                  }).toList(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class SpellData extends StatefulWidget {
  final String spellname;

  SpellData(this.spellname, {Key, key}) : super(key: key);
  @override
  _SpellDataState createState() => _SpellDataState();
}

class _SpellDataState extends State<SpellData> {
  Future<void> finishSpell() {
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

          int newXPCount = snapshot.data()['XP'] + 100;
          int newSpellCount = snapshot.data()['Spells Complete'] + 1;

          transaction.update(documentReference,
              {'XP': newXPCount, 'Spells Complete': newSpellCount});

          return newXPCount;
        })
        .then((value) => print("XP count updated to $value"))
        .catchError((error) => print("Failed to update user XPs: $error"));
  }

  Future<void> finishSpellData(double mean) {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('UserData')
        .doc('${auth.currentUser.uid}')
        .collection("Spells")
        .doc(widget.spellname);

    return FirebaseFirestore.instance
        .runTransaction((transaction) async {
          // Get the document
          DocumentSnapshot snapshot = await transaction.get(documentReference);

          if (!snapshot.exists) {
            throw Exception("User does not exist!");
          }

          bool createdTrue = snapshot.data()['Created'] = true;
          double quality = snapshot.data()['Quality'] = mean;

          transaction.update(
              documentReference, {'Created': createdTrue, 'Quality': quality});

          return createdTrue;
        })
        .then((value) => print("createdTrue updated to $value"))
        .catchError(
            (error) => print("Failed to update user createdTrue: $error"));
  }

  CollectionReference users = FirebaseFirestore.instance
      .collection('UserData')
      .doc('${auth.currentUser.uid}')
      .collection("Spells");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[800],
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomeView()));
            }),
        elevation: 0,
        centerTitle: true,
        title: Text("Spells"),
        backgroundColor: Colors.purple[800],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage("https://i.imgur.com/R3QSwPz.png"),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FutureBuilder<DocumentSnapshot>(
              future: users.doc(widget.spellname).get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data = snapshot.data.data();
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: GestureDetector(
                              onTap: () {
                                if (data['1'][0]['Own'] == true) {
                                  print("You already scanned this silly!");
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ScanView(
                                              widget.spellname,
                                              '1',
                                              data['1'][0]['Label'],
                                              data['1'][0]['Name'])));
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: data['1'][0]['Own']
                                        ? Colors.purple[800]
                                        : Colors.black,
                                    borderRadius: BorderRadius.circular(15)),
                                height: 60,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Center(
                                    child: Text(data['1'][0]['Name'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15),
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: GestureDetector(
                              onTap: () {
                                if (data['2'][0]['Own'] == true) {
                                  print("You already scanned this silly!");
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ScanView(
                                              widget.spellname,
                                              '2',
                                              data['2'][0]['Label'],
                                              data['2'][0]['Name'])));
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: data['2'][0]['Own']
                                        ? Colors.purple[800]
                                        : Colors.black,
                                    borderRadius: BorderRadius.circular(15)),
                                height: 60,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Center(
                                    child: Text(
                                      data['2'][0]['Name'],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: GestureDetector(
                              onTap: () {
                                if (data['3'][0]['Own'] == true) {
                                  print("You already scanned this silly!");
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ScanView(
                                              widget.spellname,
                                              '3',
                                              data['3'][0]['Label'],
                                              data['3'][0]['Name'])));
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: data['3'][0]['Own']
                                        ? Colors.purple[800]
                                        : Colors.black,
                                    borderRadius: BorderRadius.circular(15)),
                                height: 60,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Center(
                                    child: Text(
                                      data['3'][0]['Name'],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: GestureDetector(
                              onTap: () {
                                if (data['4'][0]['Own'] == true) {
                                  print("You already scanned this silly!");
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ScanView(
                                              widget.spellname,
                                              '4',
                                              data['4'][0]['Label'],
                                              data['4'][0]['Name'])));
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: data['4'][0]['Own']
                                        ? Colors.purple[800]
                                        : Colors.black,
                                    borderRadius: BorderRadius.circular(15)),
                                height: 60,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Center(
                                    child: Text(
                                      data['4'][0]['Name'],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: GestureDetector(
                              onTap: () {
                                if (data['5'][0]['Own'] == true) {
                                  print("You already scanned this silly!");
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ScanView(
                                              widget.spellname,
                                              '5',
                                              data['5'][0]['Label'],
                                              data['5'][0]['Name'])));
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: data['5'][0]['Own']
                                        ? Colors.purple[800]
                                        : Colors.black,
                                    borderRadius: BorderRadius.circular(15)),
                                height: 60,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Center(
                                    child: Text(
                                      data['5'][0]['Name'],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: GestureDetector(
                              onTap: () {
                                if (data['6'][0]['Own'] == true) {
                                  print("You already scanned this silly!");
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ScanView(
                                              widget.spellname,
                                              '6',
                                              data['6'][0]['Label'],
                                              data['6'][0]['Name'])));
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: data['6'][0]['Own']
                                        ? Colors.purple[800]
                                        : Colors.black,
                                    borderRadius: BorderRadius.circular(15)),
                                height: 60,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Center(
                                    child: Text(
                                      data['6'][0]['Name'],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 70),
                            child: GestureDetector(
                              onTap: () {
                                if (data['1'][0]['Own'] == true &&
                                    data['2'][0]['Own'] == true &&
                                    data['3'][0]['Own'] == true &&
                                    data['4'][0]['Own'] == true &&
                                    data['5'][0]['Own'] == true &&
                                    data['6'][0]['Own'] == true) {
                                  if (data['Created'] == false) {
                                    var mean = data['1'][0]['Rarity'] +
                                        data['2'][0]['Rarity'] +
                                        data['3'][0]['Rarity'] +
                                        data['4'][0]['Rarity'] +
                                        data['5'][0]['Rarity'] +
                                        data['6'][0]['Rarity'];

                                    var unroundedmean = mean / 6;
                                    var themean =  double.parse((unroundedmean).toStringAsFixed(2)); 
                                    finishSpell();
                                    finishSpellData(themean);

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BrewView()));
                                  } else {
                                    final snackBar = SnackBar(
                                      backgroundColor: Colors.black,
                                      content: Text(
                                        'You already created this spell!',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    );

                                    Scaffold.of(context).showSnackBar(snackBar);
                                  }
                                } else {
                                  final snackBar = SnackBar(
                                    backgroundColor: Colors.black,
                                    content: Text(
                                      'You need all the ingredients first silly!',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  );

                                  Scaffold.of(context).showSnackBar(snackBar);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: data['Created']
                                        ? Colors.grey[900]
                                        : Colors.black,
                                    borderRadius: BorderRadius.circular(15)),
                                height: 60,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Center(
                                    child: Text(
                                      "Brew",
                                      style: TextStyle(
                                          color: data['Created']
                                              ? Colors.grey[600]
                                              : Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
