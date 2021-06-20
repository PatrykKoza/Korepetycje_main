import 'package:flutter/material.dart';
import 'package:flutter_app2/models/useerr.dart';

class UserTitle  extends StatelessWidget {

  final Useerr useerr;
  UserTitle({this.useerr});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.pink[100],
          ),
          title: Text(useerr.name),
          subtitle: Text(useerr.email),
        ),
      ), 
    );
  }
}