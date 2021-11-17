import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  String reciverUid;
  String senderUid;
  String msg;
  String img;
  var date;
  var voice;



  ItemModel(
      { this.reciverUid,
         this.senderUid,
         this.msg,
        this.date,
        this.img,

      });


  ItemModel.fromJson(Map<String, dynamic> json) {
    reciverUid = json['reveverUid'];
    senderUid = json['sendUid'];
    msg = json['messg'];
    date = json['date'];
    img = json['img'];

  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reveverUid'] = this.reciverUid;
    data['sendUid'] = this.senderUid;
    data['messg'] = this.msg;
    data['date'] = this.date;
    data['img'] = this.img;

    return data;
  }
}

class PublishedDate {
  String date;

  PublishedDate({this.date});

  PublishedDate.fromJson(Map<String, dynamic> json) {
    date = json['$date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$date'] = this.date;
    return data;
  }
}