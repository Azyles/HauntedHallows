import 'dart:io';
import 'dart:ui';
import 'dart:math';
import 'package:HauntedHallows/screens/spellslist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

FirebaseAuth auth = FirebaseAuth.instance;



class ScanView extends StatefulWidget {
  final String spellname;
  final String itemname;
  final String label;
  final String realitemname;

  ScanView(this.spellname, this.itemname, this.label, this.realitemname,
      {Key, key})
      : super(key: key);
  @override
  _ScanViewState createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  Future<void> success() async {
    CollectionReference users = FirebaseFirestore.instance
        .collection('UserData')
        .doc("${auth.currentUser.uid}")
        .collection("Spells");
    // Call the user's CollectionReference to add a new user
    
    
    Random random = new Random();
    
    double randomNumber = random.nextDouble();
    
    return users
        .doc(widget.spellname)
        .update({
          widget.itemname: [
            {'Name': widget.realitemname, 'Label': widget.label, 'Own': true,'Rarity': randomNumber,}
          ],
        })
        .then((value) => print("Item Found"))
        .catchError((error) => print("Failed to update item: $error"));
  }

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

          
          int newXPCount = snapshot.data()['XP'] + 20;

          if (snapshot.data()['XP'] > 99){
            
            int newLevelCount = snapshot.data()['Level'] + 1;

            transaction.update(documentReference, {'XP': 0});
            transaction.update(documentReference, {'Level': newLevelCount});
          
          }
          else{
            transaction.update(documentReference, {'XP': newXPCount});
          }

          
          return newXPCount;
        })
        .then((value) => print("XP count updated to $value"))
        .catchError((error) => print("Failed to update user XPs: $error"));
  }

  File pickedImage;
  var text = '';

  bool imageLoaded = false;

  Future pickImage(String labele) async {



    var awaitImage = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      pickedImage = awaitImage;
      imageLoaded = true;
    });

    FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(pickedImage);

    final ImageLabeler labeler = FirebaseVision.instance.imageLabeler();
    //ImageLabelerOptions(confidenceThreshold: 0.75),
    final List<ImageLabel> cloudLabels =
        await labeler.processImage(visionImage);


    

    bool found = false;
    for (ImageLabel label in cloudLabels) {
      String thing = label.text;

      print("Label ${labele}");
      print("Found ${thing}");
      if (thing == labele) {
        found = true;
        print("Found");
      } else {
        print("${label.text}");
      }
      final double confidence = label.confidence;
      //setState(() {
      //  text = "$text ${label.text}   ${confidence.toStringAsFixed(2)}   \n";
      //
      //  print(text);
      //});
    }

    labeler.close();

    return found;
  }

  
  @override

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          //child:_cameraPreviewWidget(),
          ///*
          child: FlatButton.icon(
            icon: Icon(
              Icons.photo_camera,
              size: 100,
            ),
            label: Text(''),
            textColor: Theme.of(context).primaryColor,
            onPressed: () async {
              if (await pickImage(widget.label) == true) {
                await success();
                await addXP();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SpellData(widget.spellname)));
              } else {
                Navigator.pop(context);
                final snackBar = SnackBar(
                  content: Text('Yay! A SnackBar!'),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      // Some code to undo the change.
                    },
                  ),
                );
                Scaffold.of(context).showSnackBar(snackBar);
              }
            },
          ),
          //*/
        ));
  }
}

/*
Column(
        children: <Widget>[
          SizedBox(height: 100.0),
          imageLoaded
              ? Center(
                  child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(blurRadius: 20),
                    ],
                  ),
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                  height: 250,
                  child: Image.file(
                    pickedImage,
                    fit: BoxFit.cover,
                  ),
                ))
              : Container(),
          SizedBox(height: 10.0),
          Center(
            child: FlatButton.icon(
              icon: Icon(
                Icons.photo_camera,
                size: 100,
              ),
              label: Text(''),
              textColor: Theme.of(context).primaryColor,
              onPressed: () async {
                pickImage();
              },
            ),
          ),
          SizedBox(height: 10.0),
          SizedBox(height: 10.0),
          text == ''
              ? Text('Text will display here')
              : Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        text,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300,fontSize: 24),
                      ),
                    ),
                  ),
                ),
        ],
      ),
*/
