import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_time/auth/utils.dart';
import 'package:my_time/models/users.dart';

class StickersPage extends StatefulWidget {
  @override
  _StickersPageState createState() => _StickersPageState();
}

class _StickersPageState extends State<StickersPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Widget _extraWidgets = Container();

  void addExtraWidgets(Widget widget) {
    setState(() {
      _extraWidgets = widget;
    });
  }

  List<String> pictureUrl = [
    "sticker1.png",
    "sticker2.png",
    "sticker3.png",
    "sticker4.png"
  ];

  List<String> _availableStickers = [
    "sticker1.png",
    "sticker2.png",
    "sticker3.png",
    "sticker4.png"
  ];
  // void updateCurrentlyAvailable(List<String> stringList) {
  //   setState(() {
  //     _availableStickers = [...stringList, ...pictureUrl].toSet().toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    print("Hello");

    return FutureBuilder(
      future: getUserDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If we got an error
          if (snapshot.hasError) {
            return Center(
              child: Text(
                '${snapshot.error} occured',
                style: TextStyle(fontSize: 18),
              ),
            );

            // if we got our data
          } else if (snapshot.hasData) {
            // Extracting data from snapshot object
            final data = snapshot.data as Map<String, dynamic>;
            MyUser myUser = MyUser.fromJson(data);
            print("==============");
            print(myUser);
            print("==============");

            return Container(
              child: Column(
                children: [
                  // ..._availableStickers.map((e) => Container(
                  //       child: Text(e),
                  //     )),
                  _extraWidgets,
                  ElevatedButton(
                    onPressed: () async {
                      Random rnd = new Random();
                      var randomNumber =
                          rnd.nextInt(myUser.availableStickers.length);

                      addExtraWidgets(Container(
                          width: MediaQuery.of(context).size.width * 0.50,
                          height: MediaQuery.of(context).size.height * 0.50,
                          child: Image.asset("./assets/pictures/" +
                              myUser.availableStickers[randomNumber])));

                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(_auth.currentUser.uid)
                          .update({
                        "ownedStickers": FieldValue.arrayUnion(
                            [myUser.availableStickers[randomNumber]]),
                        "availableStickers": FieldValue.arrayRemove(
                            [myUser.availableStickers[randomNumber]])
                      });
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.pinkAccent)),
                    child: Text('Submit'),
                  ),
                ],
              ),
            );
          }
        }
        return Center(
          child: CircularProgressIndicator(),
        );
        // }
      },
    );
  }
}
