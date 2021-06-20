

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/models/lessons.dart';
import 'package:flutter_app2/models/userr.dart';
import 'package:flutter_app2/providers/productprovider.dart';
import 'package:provider/provider.dart';

class EditProduct extends StatefulWidget {
  final Product product;

  EditProduct([this.product]);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final categoryController = TextEditingController();
  final descriptionController = TextEditingController();
  String category = "Matematyka";

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    categoryController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    if (widget.product == null) {
      //New Record
      nameController.text = "";
      priceController.text = "";
      categoryController.text = "";
      descriptionController.text = "";
      new Future.delayed(Duration.zero, () {
        final productProvider = Provider.of<ProductProvider>(context,listen: false);
        productProvider.loadValues(Product());
      });
    } else {
      //Controller Update
      nameController.text=widget.product.name;
      priceController.text=widget.product.price.toString();
      categoryController.text=widget.product.category;
      descriptionController.text=widget.product.descryption;
      //State Update
      new Future.delayed(Duration.zero, () {
        final productProvider = Provider.of<ProductProvider>(context,listen: false);
        productProvider.loadValues(widget.product);
      });
      
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final user = Provider.of<Userr>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Edit Product'),backgroundColor:Colors.pink[100] ,),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: 'Product Name'),
              onChanged: (value) {
                productProvider.changeName(value);
              },
            ),
            _dropDownCategory(),
            // TextField(
            //   controller: categoryController,
            //   decoration: InputDecoration(hintText: 'Product Category'),
            //   onChanged: (value) {
            //     productProvider.changeCategory(value);
            //   },
            // ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(hintText: 'Product Description'),
              onChanged: (value) {
                productProvider.changeDescription(value);
              },
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(hintText: 'Product Price'),
              onChanged: (value) => productProvider.changePrice(value),
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              child: Text('Save'),
              onPressed: () {
                productProvider.changeuid(user.uid);
                productProvider.changeCategory(category);
                if(descriptionController.value != null && nameController.value!=null && priceController.value!=null)
                  productProvider.saveProduct();
                Navigator.of(context).pop();
              },
            ),
            (widget.product !=null) ? RaisedButton(
              color: Colors.red,
              textColor: Colors.white,
              child: Text('Delete'),
              onPressed: () {
                productProvider.removeProduct(widget.product.productId);
                Navigator.of(context).pop();
              },
            ): Container(),
          ],
        ),
      ),
    );
  }



    Widget _dropDownCategory(){
    return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('category').snapshots(),
    builder: (context, snapshot){
      if (!snapshot.hasData) return const Center(
        child: const CupertinoActivityIndicator(),
      );
      return new Container(
        child: new Row(
          children: <Widget>[
            new Expanded(
                flex: 2,
                child: new Container(
                  padding: EdgeInsets.fromLTRB(17.0,10.0,10.0,10.0),
                  child: new Text("Category"),
                )
            ),
            new Expanded(
              flex: 3,
              child:new InputDecorator(
                decoration: const InputDecoration(
                  hintText: 'Choose an category',
                  hintStyle: TextStyle(
                    fontSize: 16.0,
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.normal,
                  ),
                ),
                isEmpty: category == null,
                child: new DropdownButton(
                  value: category,
                  isDense: true,
                  onChanged: (String newValue) {
                    setState(() {
                      category = newValue;
                    });
                  },
                  items: snapshot.data.docs.map((DocumentSnapshot document) {
                    return new DropdownMenuItem<String>(
                        value: document.data()['category_name'],
                        child: new Container(
                          height: 30.0,
                          padding: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
                          child: new Text(document.data()['category_name']),
                        )
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      );
    }
  );
}
}