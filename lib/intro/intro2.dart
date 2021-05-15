import 'package:flutter/material.dart';
import 'package:my_time/auth/auth.dart';

class Intro2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                alignment: Alignment.center,
                fit: BoxFit.fill,
                image: AssetImage("./assets/pictures/background1.png"))),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
            ),
            Image.asset('./assets/pictures/running-people.png'),
            SizedBox(
              height: 50,
            ),
            Center(
                child: Text("Let's join us",
                    style: TextStyle(
                        fontSize: 50,
                        fontFamily: "Tropical",
                        color: Colors.yellow[300]))),
            SizedBox(
              height: 10,
            ),
            Text("Be prepare to begin"),
            SizedBox(
              height: 10,
            ),
            Text("your journal with us"),
            SizedBox(
              height: 10,
            ),
            Text("we will be with you "),
            SizedBox(
              height: 25,
            ),
            Container(
              width: 125,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => AuthScreen()));
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.brown)),
                child: Text(
                  "Next...",
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
