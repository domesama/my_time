import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class Diary {
  String uid;
  String title;
  String content;
  Timestamp dateTime;
  String picturePath;

  Diary({this.uid, this.title, this.content, this.dateTime, this.picturePath});

  factory Diary.fromJson(Map<String, dynamic> json) {
    print("----------------");
    print(json["title"]);
    print("----------------");

    return new Diary(
      uid: json['uid'],
      title: json['title'],
      content: json['content'],
      dateTime: json['dateTime'],
      picturePath: json['picturePath'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['uid'] = this.uid;
    data['title'] = this.title;
    data['content'] = this.content;
    data['dateTime'] = this.dateTime;
    data['picturePath'] = this.picturePath;

    return data;
  }
}
