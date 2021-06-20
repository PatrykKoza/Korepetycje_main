


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/models/useerr.dart';
import 'package:provider/provider.dart';

import 'brew_tile.dart';

class BrewList extends StatefulWidget{
  @override 
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList>{
  @override 
  Widget build(BuildContext context){
    
    final brews = Provider.of<List<Useerr>>(context);

    return ListView.builder(
      itemCount: brews.length ?? 0,
      itemBuilder: (context,index){
        return UserTitle(useerr: brews[index]);
      },
    );
  }
}