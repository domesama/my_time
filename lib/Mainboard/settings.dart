import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: const <Widget>[
          Card(
            child: ListTile(
              leading: Icon(
                Icons.person,
                size: 50,
              ),
              title: Text('Edit profile'),
              trailing: Icon(Icons.more_vert),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(
                Icons.person,
                size: 50,
              ),
              title: Text('Change email address'),
              trailing: Icon(Icons.more_vert),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(
                Icons.person,
                size: 50,
              ),
              title: Text('Forget password'),
              trailing: Icon(Icons.more_vert),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(
                Icons.exit_to_app,
                size: 50,
              ),
              title: Text('Log out'),
              trailing: Icon(Icons.more_vert),
            ),
          ),
        ],
      ),
    );
  }
}
