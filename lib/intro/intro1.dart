import 'package:flutter/material.dart';
import 'package:my_time/intro/intro2.dart';

class Intro1 extends StatelessWidget {
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
                child: Text(
              "Begin your journal",
              style: TextStyle(
                  fontSize: 50,
                  fontFamily: "Tropical",
                  color: Colors.yellow[300]),
            )),
            SizedBox(
              height: 10,
            ),
            Text("Record your daily with"),
            SizedBox(
              height: 10,
            ),
            Text("our application & "),
            SizedBox(
              height: 10,
            ),
            Text("have fun! "),
            SizedBox(
              height: 25,
            ),
            Container(
              width: 125,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Intro2()));
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.pink[200])),
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
