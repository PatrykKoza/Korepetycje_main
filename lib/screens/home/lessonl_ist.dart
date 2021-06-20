
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/models/lessons.dart';
import 'package:flutter_app2/models/useerr.dart';
import 'package:flutter_app2/screens/home/detailpage.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';

import 'brew_tile.dart';

class LesonList extends StatefulWidget{
  @override 
  _LesonListState createState() => _LesonListState();
}

class _LesonListState extends State<LesonList>{
  @override 
  Widget build(BuildContext context){

    final products = Provider.of<List<Product>>(context);

    return ListView.builder(
      itemCount: products.length ?? 0,
      itemBuilder: (context,index){
        return LesonTitle(product: products[index]);
      },
    );
    
    // final lesons = Provider.of<List<Lesons>>(context);

    // return ListView.builder(
    //   itemCount: lesons.length ?? 0,
    //   itemBuilder: (context,index){
    //     return LesonTitle(lesons: lesons[index]);
    //   },
    // );
  }
}

class LesonTitle  extends StatelessWidget {

    final Product product;
  LesonTitle({this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.pink[100],
          ),
          title: Text(product.name),
          subtitle: Text("Cena: ${product.price.toString()}zł"),
          onTap: (){
             return Navigator.push(context,MaterialPageRoute(builder: (context) => DetailPage(product: product,)));
          }
        ),
      ), 
    );
  }

  // final Lesons lesons;
  // LesonTitle({this.lesons});

  // @override
  // Widget build(BuildContext context) {
  //   return Padding(
  //     padding: EdgeInsets.only(top: 8.0),
  //     child: Card(
  //       margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
  //       child: ListTile(
  //         leading: CircleAvatar(
  //           radius: 25,
  //           backgroundColor: Colors.pink[100],
  //         ),
  //         title: Text(lesons.name),
  //         subtitle: Text("Cena: ${lesons.price.toString()}zł"),
  //         onTap: (){
  //            return Navigator.push(context,MaterialPageRoute(builder: (context) => DetailPage(leson: lesons,)));
  //         }
  //       ),
  //     ), 
  //   );
  // }
}