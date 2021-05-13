import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_time/auth/utils.dart';

class CreateDiaryPage extends StatefulWidget {
  @override
  _CreateDiaryPageState createState() => _CreateDiaryPageState();
}

class _CreateDiaryPageState extends State<CreateDiaryPage> {
  final _formKey = GlobalKey<FormState>();

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  String _title;
  String _content;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: [
        SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
              Text(
                "${selectedDate.toLocal()}".split(' ')[0],
                style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text(
                  'Select date',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.greenAccent)),
              ),
              SizedBox(
                height: 20.0,
              ),
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
                          hintText: "Title",
                          fillColor: Colors.white70),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the title';
                        }
                        _title = value;
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                          filled: true,
                          hintStyle: new TextStyle(color: Colors.grey[400]),
                          hintText: "Contents",
                          fillColor: Colors.white70),
                      // The validator receives the text that the user has entered.

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the content!';
                        }
                        _content = value;
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: getImage,
                child: Text(
                  'Pick an image',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.teal[300])),
              ),
              SizedBox(
                height: 30,
              ),
              _image != null
                  ? Container(
                      width: 250, height: 250, child: Image.file(_image))
                  : Container(),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      try {
                        await createDiary(
                            title: _title,
                            content: _content,
                            dateTime: selectedDate,
                            picturePath: "");

                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  // title: new Text("My Super title"),
                                  content: new Text("Success!"),
                                ));
                        addUser();
                      } on FirebaseException catch (e) {
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
                  child: Text("Submit your diary!")),
            ],
          ),
        ),
      ]),
    );
  }
}
