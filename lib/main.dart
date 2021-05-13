import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_time/intro/intro1.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                alignment: Alignment.center,
                fit: BoxFit.fill,
                image: AssetImage("./assets/pictures/background1.png"))),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Intro1()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'MY',
                        style: TextStyle(
                            fontSize: 100,
                            color: Colors.white,
                            fontFamily: "Tropical"),
                      ),
                      Text(
                        'TIME',
                        style: TextStyle(
                            fontSize: 100,
                            color: Colors.lightGreen[100],
                            fontFamily: "Tropical"),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: 250,
                height: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("./assets/pictures/sticker3.png"),
                  alignment: Alignment.center,
                  fit: BoxFit.fill,
                )),
                // child: Image.asset("./assets/pictures/sticker3.png")
              )
            ],
          ),
        ),
      ),
    );
  }
}
