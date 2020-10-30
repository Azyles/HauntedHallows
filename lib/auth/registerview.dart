import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nanoid/async/nanoid.dart';
import 'package:uuid/uuid.dart';

import '../HomeView.dart';
import 'loginview.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = new GlobalKey<FormState>();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> createSpell1() {
    CollectionReference users =
        FirebaseFirestore.instance.collection('UserData');
    // Call the user's CollectionReference to add a new user
    return users
        .doc("${auth.currentUser.uid}")
        .collection("Spells")
        .doc("Simple Harming Spell")
        .set({
          'Name': "Simple Harming Spell",
          'Created': false,
          'LevelNeeded': 0,
          '1': [
            {
              'Name': 'Silky cloth from Spooky Spiders',
              'Label': 'Insect',
              'Own': false
            }
          ],
          '2': [
            {
              'Name': 'Pointy Pine Cones from the Haunted Forest',
              'Label': 'Branch',
              'Own': false
            }
          ],
          '3': [
            {'Name': 'Fur of Cheshire cat', 'Label': 'Cat', 'Own': false}
          ],
          '4': [
            {
              'Name': 'The Fang of the Basilisk Serpentine',
              'Label': 'Toy',
              'Own': false
            }
          ],
          '5': [
            {
              'Name': 'The Eyeballs of Dracula.',
              'Label': 'Eyelash',
              'Own': false
            }
          ],
          '6': [
            {
              'Name': 'Branch of the old, wise oak',
              'Label': 'Branch',
              'Own': false
            }
          ],
        })
        .then((value) => print("Created Spell"))
        .catchError((error) => print("Failed to add spell: $error"));
  }

  Future<void> createSpell2() {
    CollectionReference users =
        FirebaseFirestore.instance.collection('UserData');
    // Call the user's CollectionReference to add a new user
    return users
        .doc("${auth.currentUser.uid}")
        .collection("Spells")
        .doc("Blinding Spell")
        .set({
          'Name': "Blinding Spell",
          'Created': false,
          'LevelNeeded': 2,
          '1': [
            {
              'Name': 'Candy Corn from a Witches Cave',
              'Label': 'Food',
              'Own': false
            }
          ],
          '2': [
            {
              'Name': 'Pointy Pine Cones from the Haunted Forest',
              'Label': 'Branch',
              'Own': false
            }
          ],
          '3': [
            {
              'Name': 'The Fang of the Basilisk Serpentine',
              'Label': 'Toy',
              'Own': false
            }
          ],
          '4': [
            {
              'Name': 'Silk from a Draculas Robe',
              'Label': 'Jacket',
              'Own': false
            }
          ],
          '5': [
            {'Name': 'Fur of Angry Wolf', 'Label': 'Dog', 'Own': false}
          ],
          '6': [
            {
              'Name': 'Toenails from a Grumpy Giant',
              'Label': 'Flesh',
              'Own': false
            }
          ],
        })
        .then((value) => print("Created Spell"))
        .catchError((error) => print("Failed to add spell: $error"));
  }

  Future<void> createSpell3() {
    CollectionReference users =
        FirebaseFirestore.instance.collection('UserData');
    // Call the user's CollectionReference to add a new user
    return users
        .doc("${auth.currentUser.uid}")
        .collection("Spells")
        .doc("Invisibility Spell")
        .set({
          'Name': "Invisibility Spell",
          'Created': false,
          'LevelNeeded': 7,
          '1': [
            {
              'Name': 'Candy Corn from a Witches Cave',
              'Label': 'Food',
              'Own': false
            }
          ],
          '2': [
            {
              'Name': 'Pointy Pine Cones from the Haunted Forest',
              'Label': 'Tree',
              'Own': false
            }
          ],
          '3': [
            {
              'Name': 'The Fang of the Basilisk Serpentine',
              'Label': 'Food',
              'Own': false
            }
          ],
          '4': [
            {'Name': 'Silk from a Draculas Robe', 'Label': 'Food', 'Own': false}
          ],
          '5': [
            {'Name': 'Fur of Angry Wolf', 'Label': 'Food', 'Own': false}
          ],
          '6': [
            {
              'Name': 'Toenails from a Grumpy Giant',
              'Label': 'Food',
              'Own': false
            }
          ],
        })
        .then((value) => print("Created Spell"))
        .catchError((error) => print("Failed to add spell: $error"));
  }

  Future<void> createSpell4() {
    CollectionReference users =
        FirebaseFirestore.instance.collection('UserData');
    // Call the user's CollectionReference to add a new user
    return users
        .doc("${auth.currentUser.uid}")
        .collection("Spells")
        .doc("Summoning Spell")
        .set({
          'Name': "Summoning Spell",
          'Created': false,
          'LevelNeeded': 10,
          '1': [
            {
              'Name': 'Candy Corn from a Witches Cave',
              'Label': 'Food',
              'Own': false
            }
          ],
          '2': [
            {
              'Name': 'Pointy Pine Cones from the Haunted Forest',
              'Label': 'Tree',
              'Own': false
            }
          ],
          '3': [
            {
              'Name': 'The Fang of the Basilisk Serpentine',
              'Label': 'Food',
              'Own': false
            }
          ],
          '4': [
            {'Name': 'Silk from a Draculas Robe', 'Label': 'Food', 'Own': false}
          ],
          '5': [
            {'Name': 'Fur of Angry Wolf', 'Label': 'Food', 'Own': false}
          ],
          '6': [
            {
              'Name': 'Toenails from a Grumpy Giant',
              'Label': 'Food',
              'Own': false
            }
          ],
        })
        .then((value) => print("Created Spell"))
        .catchError((error) => print("Failed to add spell: $error"));
  }

  Future<void> createSpell5() {
    CollectionReference users =
        FirebaseFirestore.instance.collection('UserData');
    // Call the user's CollectionReference to add a new user
    return users
        .doc("${auth.currentUser.uid}")
        .collection("Spells")
        .doc("Grand Witche's Curse")
        .set({
          'Name': "Grand Witche's Curse",
          'Created': false,
          'LevelNeeded': 15,
          '1': [
            {
              'Name': 'Candy Corn from a Witches Cave',
              'Label': 'Food',
              'Own': false
            }
          ],
          '2': [
            {
              'Name': 'Pointy Pine Cones from the Haunted Forest',
              'Label': 'Tree',
              'Own': false
            }
          ],
          '3': [
            {
              'Name': 'The Fang of the Basilisk Serpentine',
              'Label': 'Food',
              'Own': false
            }
          ],
          '4': [
            {'Name': 'Silk from a Draculas Robe', 'Label': 'Food', 'Own': false}
          ],
          '5': [
            {'Name': 'Fur of Angry Wolf', 'Label': 'Food', 'Own': false}
          ],
          '6': [
            {
              'Name': 'Toenails from a Grumpy Giant',
              'Label': 'Food',
              'Own': false
            }
          ],
        })
        .then((value) => print("Created Spell"))
        .catchError((error) => print("Failed to add spell: $error"));
  }

  /*
  Future<void> createSpell2() {
    CollectionReference users =
        FirebaseFirestore.instance.collection('UserData');
    // Call the user's CollectionReference to add a new user
    return users
        .doc("${auth.currentUser.uid}")
        .collection("Spells")
        .doc("Blinding Spell")
        .set({'Created': false,
        'LevelNeeded': 0,
        'Fur of Cheshire cat': false,})
        .then((value) => print("Created Spell"))
        .catchError((error) => print("Failed to add spell: $error"));
  }
  */
  Future<void> userData() async {
    var custom_length_id = await nanoid(7);
    CollectionReference users =
        FirebaseFirestore.instance.collection('UserData');
    // Call the user's CollectionReference to add a new user
    return users
        .doc("${auth.currentUser.uid}")
        .set({
          'XP': 0,
          'Level': 0,
          'Cash': 0,
          'Character': "None",
          'Social Alerts': 0,
          'Spells Complete': 0,
          'Event Alerts': 0,
          'UserUID': '${custom_length_id}',
        })
        .then((value) => print("Created Spell"))
        .catchError((error) => print("Failed to add spell: $error"));
  }

  

  String _feedback = '';
  bool checkValue = false;

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  signUpEmail(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // ignore: unnecessary_statements
      userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(8, 8, 8, 1),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Center(
            child: Text(
              'Register',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 46,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.10,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.deepOrange, width: 2),
                        color: Color.fromRGBO(24, 24, 24, 0),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.white),
                              border: InputBorder.none,
                              hintText: 'Email'),
                          validator: (value) {
                            if (value == null || value == '') {
                              return 'Email cannot be blank';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.85,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.deepOrange, width: 2),
                        color: Color.fromRGBO(24, 24, 24, 0),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.white),
                              border: InputBorder.none,
                              hintText: 'Password'),
                          validator: (value) {
                            if (value == null || value == '') {
                              return 'Password cannot be blank';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.85,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Center(
            child: Container(
              child: new Material(
                child: new InkWell(
                  onTap: () async {
                    if (_formKey.currentState.validate()) {
                      await signUpEmail(
                        _emailController.text,
                        _passwordController.text,
                      );
                      userData();
                      createSpell1();
                      createSpell2();
                      createSpell3();
                      createSpell4();
                      createSpell5();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomeView()));
                    }
                  },
                  child: new Container(
                    child: Center(
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.height * 0.03,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                color: Colors.transparent,
              ),
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(
                color: Colors.deepPurple[400],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.025,
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Text(
                _feedback,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red, fontSize: 15.5),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignInView()));
        },
        backgroundColor: Colors.deepOrange[300],
        child: Icon(Icons.wb_cloudy),
      ),
    );
  }
}
