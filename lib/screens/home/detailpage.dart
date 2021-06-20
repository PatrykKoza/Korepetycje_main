import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/models/lessons.dart';
import 'package:flutter_app2/models/userr.dart';
import 'package:flutter_app2/providers/cartitemprovider.dart';
import 'package:flutter_app2/screens/home/appbar.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {

  final Product product;
  DetailPage({this.product});
  @override 
  _DetailPageState createState()=> _DetailPageState();
  // final Lesons leson;
  // DetailPage({this.leson});
  // @override 
  // _DetailPageState createState()=> _DetailPageState();
}

class _DetailPageState extends State<DetailPage>{
    @override 
  Widget build(BuildContext context){
     final cartItemProvider = Provider.of<CartItemProvider>(context);
    final user = Provider.of<Userr>(context);
    return Scaffold(
      appBar: BaseAppBar(
          title: Text('title'),
          appBar: AppBar(),
          widgets: <Widget>[Icon(Icons.more_vert)],
        ),
      body: Container(
        child: Column(
          children:<Widget> [
            Card(child: ListTile(
           title: Text(widget.product.name),
           subtitle: Text(widget.product.descryption),
           ),
           ),
           SizedBox(
             width: double.infinity,
             child: RaisedButton(
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            ),
            color: Color(0xFFFDFDFD),
            child: Text(
            'ADD TO CART',
            style: TextStyle(
            color: Color(0xFFECB6B6),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
            ),
            ),
            onPressed:() async{
                cartItemProvider.changequantity("1");
                cartItemProvider.changeproductId(widget.product.productId);
                cartItemProvider.changeuid(user.uid);
                cartItemProvider.saveCartItem();
                Navigator.of(context).pop();
            } ,
           ),
           ),
           
          ],
          ),
      // child: Card(
      //   child: ListTile(
      //     title: Text(widget.product.name),
      //     subtitle: Text(widget.product.descryption),
      //   ),
      // ),
    ),
    );
  }

}