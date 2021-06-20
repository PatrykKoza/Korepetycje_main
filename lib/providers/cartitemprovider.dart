import 'package:flutter/material.dart';
import 'package:flutter_app2/models/cartitem.dart';
import 'package:flutter_app2/models/lessons.dart';
import 'package:flutter_app2/services/auth.dart';
import 'package:flutter_app2/services/database.dart';
import 'package:uuid/uuid.dart';

class CartItemProvider with ChangeNotifier {
  final firestoreService = DataBaseService();
  final authService = AuthService();
  String _cartItemId;
  String _productId;
  String _uid;
  int _quantity;
  var uuid = Uuid();

  //Setters
  changeuid(String value) {
    _uid = value;
    notifyListeners();
  }
  changequantity(String value) {
    _quantity = int.parse(value);
    notifyListeners();
  }
  changeproductId(String value){
    _productId = value;
    notifyListeners();
  }

  loadValues(CartItem cartItem){
    _cartItemId = cartItem.cartItemId;
    _productId=cartItem.productId;
    _quantity = cartItem.quantity;
    _uid = cartItem.uid;
  }


  saveCartItem() {
    print(_cartItemId);
    if (_cartItemId == null) {
      var newCartItem = CartItem(uid: _uid,productId: _productId,quantity: _quantity,cartItemId: uuid.v4());
      firestoreService.saveCartItem(newCartItem);
    } else {
      //Update
      var updatedCartItem = CartItem(uid: _uid,productId: _productId, quantity: _quantity,cartItemId: _cartItemId);
      firestoreService.saveCartItem(updatedCartItem);
    }
  }

  removeCartItem(String cartItemId){
    firestoreService.removeCartItem(cartItemId);
  }

  addquantity(String cartItemId,int quantity){
    firestoreService.addquantity(cartItemId,quantity);
  }

}