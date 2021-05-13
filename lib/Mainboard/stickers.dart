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
  Widget _extraWidgets =
      Container(child: Image.asset("./assets/pictures/random.png"));

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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ..._availableStickers.map((e) => Container(
                  //       child: Text(e),
                  //     )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'MY',
                        style: TextStyle(
                            fontSize: 100,
                            color: Colors.brown,
                            fontFamily: "Tropical"),
                      ),
                      Text(
                        'TIME',
                        style: TextStyle(
                            fontSize: 100,
                            color: Colors.lightGreen[300],
                            fontFamily: "Tropical"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  _extraWidgets,
                  ElevatedButton(
                    onPressed: () async {
                      if (myUser.availableStickers.length > 0) {
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
                      } else {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                content: new SingleChildScrollView(
                                    child: Text(
                                        "You already owned all the stickers!"))));
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.pinkAccent)),
                    child: Text("Let's random!"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                      content: new SingleChildScrollView(
                                          child: Column(
                                    children: [
                                      ...myUser.ownedStickers.map((e) =>
                                          Image.asset("./assets/pictures/" + e))
                                    ],
                                  ))));
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.teal[200])),
                        child: Text('Obtained stickers',
                            style: TextStyle(color: Colors.brown)),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (myUser.availableStickers.length > 0) {
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                        content: new SingleChildScrollView(
                                            child: Column(
                                      children: [
                                        ...myUser.availableStickers.map((e) =>
                                            Image.asset(
                                                "./assets/pictures/" + e))
                                      ],
                                    ))));
                          } else {
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                    content: new SingleChildScrollView(
                                        child: Text(
                                            "You already owned all the stickers!"))));
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.yellow[200])),
                        child: Text(
                          'Available stickers',
                          style: TextStyle(color: Colors.brown),
                        ),
                      ),
                    ],
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
