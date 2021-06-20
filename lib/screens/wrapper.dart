import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app2/models/userr.dart';
import 'package:flutter_app2/screens/authenticate/authenticate.dart';
import 'package:flutter_app2/screens/authenticate/login_screen.dart';
import 'package:flutter_app2/screens/home/home.dart';
import 'package:flutter_app2/utilities/constants.dart';
import 'package:flutter_app2/screens/authenticate/sign_up_screen.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context){

    final user =Provider.of<Userr>(context);
    print(user);
    if(user == null){
      return Authenticate();
    }else {
      return Home();
    }
  }
}