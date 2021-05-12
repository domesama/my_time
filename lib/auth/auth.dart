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
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _wantsLogin ? LoginPage() : RegisterPage(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ..._wantsLogin ? _loginSwitchMessage : _registerSwitchMessage
                ],
              ),
            ]),
      ),
    );
  }
}
