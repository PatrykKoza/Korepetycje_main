import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/models/category.dart';
import 'package:flutter_app2/services/auth.dart';
import 'package:flutter_app2/services/database.dart';

class Lessons{
  final String uid;
  final String name;
  final String descryption;
  final double price;

  Lessons({this.uid,this.name,this.descryption,this.price});
}

class Lesons{
  final String name;
  final String descryption;
  final double price;
  final String category;

  Lesons({this.name,this.descryption,this.price,this.category});
}

  
class Product{
  final String productId;
  final String name;
  final double price;
  final String category;
  final String descryption;
  final String uid;

  Product({this.productId,this.price, this.name,this.category,this.descryption,this.uid});

  Map<String,dynamic> toMap(){
    return {
      'productId' : productId,
      'name' : name,
      'price' : price,
      'category' : category,
      'description' : descryption,
      'uid' : uid
    };
  }
  Product.fromSnapchot(DocumentSnapshot snapshot)
      : productId = snapshot['productId'],
        name = snapshot['name'],
        price = snapshot['price'],
        category = snapshot['category'],
        descryption = snapshot['description'],
        uid = snapshot['uid'];

  Product.fromFirestore(Map<String, dynamic> firestore)
      : productId = firestore['productId'],
        name = firestore['name'],
        price = firestore['price'],
        category = firestore['category'],
        descryption = firestore['description'],
        uid = firestore['uid'];
}
