import 'package:flutter/material.dart';
import 'package:flutter_app2/models/userr.dart';
import 'package:flutter_app2/screens/home/settings.dart';
import 'package:flutter_app2/services/auth.dart';
import 'package:flutter_app2/services/database.dart';
import 'package:flutter_app2/utilities/loading.dart';
import 'package:provider/provider.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = Colors.red;
  final Text title;
  final AppBar appBar;
  final List<Widget> widgets;

  const BaseAppBar({Key key, this.title, this.appBar, this.widgets})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    final AuthService _auth = AuthService();
    final user = Provider.of<Userr>(context);

    void _showSettingsPanel(){
      showModalBottomSheet(
        context: context,
        builder: (context){
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 60),
            child: SettingsForm(),
          );
        }
      );
    }

    return StreamBuilder<UserData>(
      stream: DataBaseService(uid: user.uid).userData,
      builder: (context,snapshot){
        if(snapshot.hasData){
          UserData userData = snapshot.data;
    return AppBar(
        title: Text(userData.name),
        backgroundColor: Color(0xFFECB6B6),
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label:  Text('logout'),
            onPressed: () async{
              await _auth.signOut();
            },
          ),
          FlatButton.icon(
            icon: Icon(Icons.settings),
            label: Text('settings'),
            onPressed: ()=> _showSettingsPanel(),
          ),
          
        ],
    );
    }else{
      return Loading();
    }
      }
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}