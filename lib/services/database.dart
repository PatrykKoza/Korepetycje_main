import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app2/models/cartitem.dart';
import 'package:flutter_app2/models/category.dart';
import 'package:flutter_app2/models/lessons.dart';
import 'package:flutter_app2/models/useerr.dart';
import 'package:flutter_app2/models/userr.dart';

class DataBaseService{

  final String uid;
  DataBaseService({this.uid});
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference lessonsCollection = FirebaseFirestore.instance.collection('lessons');
  final CollectionReference categoryCollection = FirebaseFirestore.instance.collection('category');
  final CollectionReference productCollection = FirebaseFirestore.instance.collection('Product');
  final CollectionReference cartItemCollection = FirebaseFirestore.instance.collection("cartItem");


  Future updateUserData(String name, String phone, String email) async{
    return await brewCollection.doc(uid).set({
      'name' : name,
      'phone' : phone,
      'email' : email,
    });
  }

  List<Useerr> _userListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Useerr(
        name: doc.data()['name'] ?? '',
        email: doc.data()['email'] ?? '',
        phone: doc.data()['phone'] ?? '',
      );
    }).toList();
  }

  Stream<List<Useerr>> get brews {
    return brewCollection.snapshots().map(_userListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData{
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  //userdata from snapchot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data()['name'],
      email: snapshot.data()['email'],
      phone: snapshot.data()['phone']
    );
  }

  ////For lessons features /////
//   List<Lesons> _lessonListFromSnapshot(QuerySnapshot snapshot){
//     return snapshot.docs.map((doc){
//       return Lesons(
//         name: doc.data()['name'] ?? '',
//         descryption: doc.data()['description'] ?? '',
//         price: doc.data()['price'] ?? 0 ,
//         category: doc.data()['category'] ?? '',
//       );
//     }).toList();
//   }

//  Stream<List<Lesons>> get lesons {
//     return lessonsCollection.snapshots().map(_lessonListFromSnapshot);
//   }

//   Stream<List<Lesons>> lesonsCat(String cat){
//     final Query mylist = lessonsCollection.where("category", isEqualTo: cat);
//     if(cat == "Wszystko")
//       return lesons;
//     return mylist.snapshots().map(_lessonListFromSnapshot);
//   }

//   Future updateLesonList(String name, String description, double price, String category) async{
//     return await lessonsCollection.doc().set({
//       'name' : name,
//       'description' : description,
//       'price' : price,
//       'category' : category,
//     });
//   }
  ////END LESSONS////
  ///
  ////For lessons features /////
  Stream<List<Category>> get category {
    return lessonsCollection.snapshots().map(_categoryListFromSnapshot);
  }

  List<Category> _categoryListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Category(
        name: doc.data()['category_name'] ?? '',
      );
    }).toList();
  }
  ////END CATEGORY
  



///__PRODUCT__///
  Future<void> saveProduct(Product product){
    return productCollection.doc(product.productId).set(product.toMap());
  }

  Stream<List<Product>> getProducts(){
    return productCollection.snapshots().map((snapshot) => snapshot.docs.map((document) => Product.fromFirestore(document.data())).toList());
  }

  Future<void> removeProduct(String productId){
    return productCollection.doc(productId).delete();
  }

  Stream<List<Product>> productCat(String cat){
    final Query mylist = productCollection.where("category", isEqualTo: cat);
    if(cat == "Wszystko")
      return getProducts();
    return mylist.snapshots().map((snapshot) => snapshot.docs.map((document) => Product.fromFirestore(document.data())).toList());
  }

  Stream<List<Product>> productOwner(String owner){
    final Query mylist = productCollection.where("uid", isEqualTo: owner);
    return mylist.snapshots().map((snapshot) => snapshot.docs.map((document) => Product.fromFirestore(document.data())).toList());
  }

  Stream<Product> getProductById(String id){
    final Query myproduct = productCollection.where("productId",isEqualTo: id);
    return myproduct.snapshots().map((snapshot) => snapshot.docs.map((document) => Product.fromFirestore(document.data())).toList().elementAt(0));
  }
///__END_PRODUCT__///


///__CART_ITEM__///
  Future<void> saveCartItem(CartItem cartItem){
    return cartItemCollection.doc(cartItem.cartItemId).set(cartItem.toMap());
  }

  Future<void> removeCartItem(String cartItemId){
    return cartItemCollection.doc(cartItemId).delete();
  }

  Future<void> addquantity(String cartItemId,int quantity){
    return cartItemCollection.doc(cartItemId).update({'quantity': quantity});
  }

  Stream<List<CartItem>> cartItemOwner(String owner){
    final Query mylist = cartItemCollection.where("uid", isEqualTo: owner);
    return mylist.snapshots().map((snapshot) => snapshot.docs.map((document) => CartItem.fromFirestore(document.data())).toList());
  }
///__END_CART_ITEM__///
}