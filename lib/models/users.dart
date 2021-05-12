import 'package:flutter/widgets.dart';

class MyUser {
  String uid;
  String email;
  String profileImage;
  List<String> ownedStickers;
  List<String> availableStickers;

  MyUser(
      {this.uid,
      this.email,
      this.ownedStickers,
      this.profileImage,
      this.availableStickers});

  factory MyUser.fromJson(Map<String, dynamic> json) {
    var ownedStickersFromJson = json['ownedStickers'];
    var availableStickersFromJson = json['availableStickers'];

    List<String> ownedStickersList =
        new List<String>.from(ownedStickersFromJson);

    List<String> availableStickersList =
        new List<String>.from(availableStickersFromJson);

    // List<String> ownedStickersList =
    // ownedStickersFromJson as List<String>;
    // [...ownedStickersFromJson] as List<String>;

    // (ownedStickersFromJson as List<String>)?.map((item) => item)?.toList();

    return new MyUser(
      uid: json['uid'],
      email: json['email'],
      profileImage: json['ownedStickersList'],
      ownedStickers: ownedStickersList,
      availableStickers: availableStickersList,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['uid'] = this.uid;
    data['email'] = this.email;
    data['profileImage'] = this.profileImage;
    data['ownedStickers'] = this.ownedStickers;
    data['availableStickers'] = this.availableStickers;

    return data;
  }
}
