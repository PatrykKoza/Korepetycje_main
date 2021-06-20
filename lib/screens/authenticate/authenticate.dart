import 'package:flutter/material.dart';
import 'package:flutter_app2/screens/authenticate/login_screen.dart';
import 'package:flutter_app2/screens/authenticate/sign_up_screen.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState()=>_AuthenticateState();
}

class _AuthenticateState extends State<Authenticate>{
  
  bool showsignIn =true;
  void toogleView(){
    setState(()=>showsignIn = !showsignIn);
  }

  @override 
  Widget build(BuildContext context){
    if(showsignIn){
      return LoginScreen(toogleView: toogleView);
    }else{
      return SignUpScreen(toogleView: toogleView);
    }
  }
}