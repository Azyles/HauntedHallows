
import 'package:HauntedHallows/auth/registerview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../HomeView.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class SignInView extends StatelessWidget {
  final _formKey = new GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  signInEmail(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // ignore: unnecessary_statements
      userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
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
              'Login',
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
                      border: Border.all(color: Colors.deepOrange,width: 2),
                    color: Color.fromRGBO(24, 24, 24, 0),
                    
                    borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.white),
                              border: InputBorder.none, hintText: 'Email'),
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
                      border: Border.all(color: Colors.deepOrange,width: 2),
                    color: Color.fromRGBO(24, 24, 24, 0),
                    borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                           style: TextStyle(color: Colors.white),
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                             hintStyle: TextStyle(color: Colors.white),
                              border: InputBorder.none, hintText: 'Password'),
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
                      await signInEmail(
                        _emailController.text,
                        _passwordController.text,
                      );
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomeView()));
                    }
                  },
                  child: new Container(
                    child: Center(
                      child: Text(
                        'Sign In',
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
        ],
      ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignUpView()));
        },
        backgroundColor: Colors.deepOrange[300],child: Icon(Icons.wb_cloudy),),
        );
  }
}