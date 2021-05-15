import 'package:flutter/material.dart';
import 'package:my_time/auth/login.dart';
import 'package:my_time/auth/register.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _wantsLogin = false;

  void _switchPage() {
    setState(() {
      _wantsLogin = !_wantsLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _loginSwitchMessage = [
      Text("Do not have an account yet? "),
      InkWell(
          onTap: () => _switchPage(),
          child: Text(
            "Register here!",
            style: TextStyle(color: Colors.pinkAccent),
          ))
    ];
    List<Widget> _registerSwitchMessage = [
      Text("Already have an account? "),
      InkWell(
          onTap: () => _switchPage(),
          child: Text(
            "Login here!",
            style: TextStyle(color: Colors.pinkAccent),
          ))
    ];

    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  alignment: Alignment.center,
                  fit: BoxFit.fill,
                  image: AssetImage("./assets/pictures/background1.png"))),
          child: Center(
            child: Stack(children: [
              SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Row(
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
                                color: Colors.lightGreen[300],
                                fontFamily: "Tropical"),
                          ),
                        ],
                      ),
                      _wantsLogin ? LoginPage() : RegisterPage(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ..._wantsLogin
                              ? _loginSwitchMessage
                              : _registerSwitchMessage
                        ],
                      ),
                    ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
