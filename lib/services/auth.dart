import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app2/models/userr.dart';
import 'package:flutter_app2/services/database.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Userr us = null;
  //create user obj base on FirebaseUser
  Userr _userFromFireBaseUser(User user){
    return user!=null ? us=Userr(uid: user.uid) : us=null;
  }

  String get getUs{
    if(us!=null)
      return us.getUid();
    return null;
  }

  //auth change user stream
  Stream<Userr> get user{
    return _auth.authStateChanges().map(_userFromFireBaseUser);
  }

  // sing in anon
  Future signInAnon() async{
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFireBaseUser(user);
    }catch(e){
    print(e.toString());
    return null;
    }
  }
  //sign in
  Future signInWithEmailAndPassword(String email, String password) async{
  try{
    UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    User user = result.user;
    return _userFromFireBaseUser(user);
  }catch(e){
    print(e.toString());
    return null;
  }
}  
//register
Future registerwithEmailandPassword(String email, String password, String name, String phone) async{
  try{
    UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    User user = result.user;

    await DataBaseService(uid: user.uid).updateUserData(name,phone,email);

    return _userFromFireBaseUser(user);
  }catch(e){
    print('test');
    print(e.toString());
    return null;
  }
}
//Sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  // 
}