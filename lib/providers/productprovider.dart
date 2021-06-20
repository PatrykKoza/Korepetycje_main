import 'package:flutter/material.dart';
import 'package:flutter_app2/models/lessons.dart';
import 'package:flutter_app2/services/auth.dart';
import 'package:flutter_app2/services/database.dart';
import 'package:uuid/uuid.dart';

class ProductProvider with ChangeNotifier {
  final firestoreService = DataBaseService();
  final authService = AuthService();
  String _name;
  double _price;
  String _productId;
  String _uid;
  String _category;
  String _description;
  var uuid = Uuid();

  //Getters
  String get name => _name;
  double get price => _price;

  //Setters

  changeuid(String value) {
    _uid = value;
    notifyListeners();
  }

  changeName(String value) {
    _name = value;
    notifyListeners();
  }

  changePrice(String value) {
    _price = double.parse(value);
    notifyListeners();
  }

  changeCategory(String value) {
    _category =value;
    notifyListeners();
  }

  changeDescription(String value){
    _description = value;
    notifyListeners();
  }

  loadValues(Product product){
    _name=product.name;
    _price=product.price;
    _productId=product.productId;
    _category = product.category;
    _description = product.descryption;
    _uid = product.uid;
  }


  saveProduct() {
    print(_productId);
    if (_productId == null) {
      var newProduct = Product(name: _name, price: _price, uid: _uid, descryption: _description,category: _category,productId: uuid.v4());
      firestoreService.saveProduct(newProduct);
    } else {
      //Update
      var updatedProduct = Product(name: _name, price: _price, uid: _uid, descryption: _description,category: _category,productId: _productId);
      firestoreService.saveProduct(updatedProduct);
    }
  }

  removeProduct(String productId){
    firestoreService.removeProduct(productId);
  }

  getproduct(String productId){
    firestoreService.getProductById(productId);
  }

}