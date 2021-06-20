class Userr{
  final String uid;

  Userr({this.uid});

  String getUid(){
    return uid;
  }
}

class UserData{

  final String uid;
  final String name;
  final String email;
  final String phone;

  UserData({this.uid,this.name,this.email,this.phone});
  
}