import 'package:flutter/material.dart';
import 'package:flutter_app2/models/userr.dart';
import 'package:flutter_app2/services/database.dart';
import 'package:flutter_app2/utilities/constants.dart';
import 'package:flutter_app2/utilities/loading.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app2/utilities/validators.dart';

class SettingsForm extends StatefulWidget{
  @override 
  _SettingsFormState createState()=>_SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm>{

  final _formKey = GlobalKey<FormState>();

  String _currentName;
  String _currentPhone;

  @override 
  Widget build(BuildContext context){

    final user = Provider.of<Userr>(context);
    
    return StreamBuilder<UserData>(
      stream: DataBaseService(uid: user.uid).userData,
      builder: (context,snapshot){
        if(snapshot.hasData){
          UserData userData = snapshot.data;
            return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Update your data',
                  style: TextStyle(fontSize: 18),
                ),
              SizedBox(height: 20),
              TextFormField(
                initialValue: _currentName ?? userData.name,
                validator: (val)=>val.isEmpty ? 'Please enter a name' : null,
                onChanged: (val)=>setState(()=>_currentName=val),
                            decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Color(0xFF393939),
                    ),
                    hintText: 'Enter your Name',
                    hintStyle: kHintTextStyle,
                  ),
              ),
              SizedBox(height: 20),
                TextFormField(
                initialValue: _currentName ?? userData.phone,
                validator: (val)=>val.isEmpty || val.isPhoneValid()==false ? 'Please enter a phone' : null,
                onChanged: (val)=>setState(()=>_currentPhone=val),
                            decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Color(0xFF393939),
                    ),
                    hintText: 'Enter your Name',
                    hintStyle: kHintTextStyle,
                  ),
              ),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: ()async{
                  if(_formKey.currentState.validate()){
                    await DataBaseService(uid: user.uid).updateUserData(
                      _currentName ?? userData.name,
                      _currentPhone ?? userData.phone,
                      userData.email);
                  }
                  Navigator.pop(context);
                },
              )
              ],
            ),
          );
        }else{
          return Loading();
        }
      }
    );
  }
}