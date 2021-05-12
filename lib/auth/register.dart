import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_time/auth/utils.dart';
import 'package:my_time/intro/intro1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String _currentPass = "";
  var _email = "";

  void _setCurrentPass(String newPass) {
    setState(() {
      _currentPass = newPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.70,
      height: MediaQuery.of(context).size.height * 0.50,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        filled: true,
                        hintStyle: new TextStyle(color: Colors.grey[400]),
                        hintText: "Please enter the email",
                        fillColor: Colors.white70),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the email';
                      }
                      if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return "Please enter a valid email address";
                      }
                      _email = value;
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        filled: true,
                        hintStyle: new TextStyle(color: Colors.grey[400]),
                        hintText: "Please enter yoyr password",
                        fillColor: Colors.white70),
                    // The validator receives the text that the user has entered.
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the password';
                      }
                      _setCurrentPass(value);
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        filled: true,
                        hintStyle: new TextStyle(color: Colors.grey[400]),
                        hintText: "Please re-enter your password",
                        fillColor: Colors.white70),
                    // The validator receives the text that the user has entered.
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the password';
                      }
                      if (value != _currentPass) {
                        return "The given passwords do not matched";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  try {
                    await _auth.createUserWithEmailAndPassword(
                        email: _email, password: _currentPass);

                    CollectionReference users =
                        FirebaseFirestore.instance.collection('users');

                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              // title: new Text("My Super title"),
                              content: new Text("Success!"),
                            ));
                    addUser();
                  } on FirebaseAuthException catch (e) {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              content: new Text(e.message),
                            ));
                    print('Failed with error code: ${e.code}');
                    print(e.message);
                  }
                }
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.pinkAccent)),
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
