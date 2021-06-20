import 'package:flutter/material.dart';
import 'package:flutter_app2/models/cartitem.dart';
import 'package:flutter_app2/models/lessons.dart';
import 'package:flutter_app2/providers/cartitemprovider.dart';
import 'package:flutter_app2/providers/productprovider.dart';
import 'package:flutter_app2/screens/authenticate/login_screen.dart';
import 'package:flutter_app2/screens/authenticate/sign_up_screen.dart';
import 'package:flutter_app2/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app2/services/auth.dart';
import 'package:flutter_app2/services/database.dart';
import 'package:provider/provider.dart';

import 'models/userr.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(create: (context) => ProductProvider()),
        ChangeNotifierProvider<CartItemProvider>(create: (context)=> CartItemProvider()),
        StreamProvider<Userr>.value(value:AuthService().user,initialData: null,),
        StreamProvider<List<Product>>.value(value: DataBaseService().getProducts(), initialData: []),  ///to bylo skomentowane
      ],
      child: MaterialApp(
        title: 'Flutter Login UI',
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}