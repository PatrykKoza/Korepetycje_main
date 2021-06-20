

import 'package:flutter/material.dart';
import 'package:flutter_app2/models/lessons.dart';
import 'package:flutter_app2/models/userr.dart';
import 'package:provider/provider.dart';

import 'edit_products.dart';

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<Product>>(context);
    final user = Provider.of<Userr>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Products'),
          backgroundColor: Colors.pink[100],
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                size: 30.0,
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EditProduct()));
              },
            )
          ],
        ),
        body: (products != null)
            ? ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(products[index].name??"test"),
                    trailing: Text(products[index].price.toString()??"test2"),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditProduct(products[index])));
                    },
                  );
                })
            : Center(child: CircularProgressIndicator()));
  }
}