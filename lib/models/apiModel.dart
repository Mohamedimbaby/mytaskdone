import 'dart:core';

import 'dart:core';

import 'package:flutterapp/models/subModel.dart';

class apiModel {

  int id  ;
  String  title   ;
  List<String> img ;
   String interest   ;
  int price  ;
   String date ;
  String address ;
   String trainerName   ;
  String  trainerImg  ;
  String trainerInfo   ;
  String  occasionDetail ;
  String latitude   ;
  String longitude  ;
  bool isLiked  =false;
  bool isSold  =false;
  bool isPrivateEvent  =false;
  bool hiddenCashPayment  =false;
  subModel reservTypes;

  apiModel({
      this.id,
      this.title,
      this.img,
      this.interest,
      this.price,
      this.date,
      this.address,
      this.trainerName,
      this.trainerImg,
      this.trainerInfo,
      this.occasionDetail,
      this.latitude,
      this.longitude,
      this.isLiked,
      this.isSold,
    this.reservTypes,
      this.isPrivateEvent,
      this.hiddenCashPayment,
      });

  factory apiModel.fromJson (Map<String , dynamic > json ){
    return apiModel(
        id: json['id'],
        title: json['title'],
        interest: json['interest'],
        price: json['price'],
        date: json['date'],
        address: json['address'],
        trainerName: json['trainerName'],
       trainerImg: json['trainerImg'],
        trainerInfo: json['trainerInfo'],
     occasionDetail: json['occasionDetail'],
     latitude: json['latitude'],
     longitude: json['longitude'],
        isLiked: json['isLiked'],
        isSold: json['isSold'],
       isPrivateEvent: json['isPrivateEvent'],
        hiddenCashPayment: json['hiddenCashPayment'],
        reservTypes : subModel.fromJson (json['reservTypes'][0])
    );
  }

}