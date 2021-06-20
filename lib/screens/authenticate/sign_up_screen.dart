import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app2/screens/wrapper.dart';
import 'package:flutter_app2/services/auth.dart';
import 'package:flutter_app2/utilities/constants.dart';
import 'package:flutter_app2/screens/authenticate/login_screen.dart';
import 'package:flutter_app2/utilities/loading.dart';
import 'package:flutter_app2/utilities/validators.dart';

class SignUpScreen extends StatefulWidget {
  final Function toogleView;
  SignUpScreen({this.toogleView});
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>{
   bool _rememberMe = false;
  bool loading = false;
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email ='';
  String password = '';
  String name='';
  String phone='';
  String error='';

   @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      body: Container(
        decoration: BoxDecoration(
       image: DecorationImage(
       image: AssetImage("assets/images/tlo.jpeg"),
       fit: BoxFit.cover,
        ),
        ),
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
        horizontal: 40.0,
        vertical: 120.0,
        ),
        child: Form(
          key: _formKey,
          child: Column(       
            children: <Widget>[
              Text(
              'Sign Up',
                style: TextStyle(
                color: Color(0xFF393939),
                fontFamily: 'OpenSans',
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              _buildNameTF(),
              SizedBox(height: 20),
              _buildEmailTF(),
              SizedBox(height: 20),
              _buildPasswordTF(),
              SizedBox(height: 20),
              _buildConfirmPasswordTF(),
              SizedBox(height: 20),
              _buildPhoneTF(),
              SizedBox(height: 20),
               RaisedButton(
                                        padding: EdgeInsets.all(15.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30.0),
                                        ),
                                        color: Color(0xFFFDFDFD),
                                        child: Text(
                                          'REGISTER',
                                          style: TextStyle(
                                            color: Color(0xFFECB6B6),
                                            letterSpacing: 1.5,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'OpenSans',
                                          ),
                                        ),
                onPressed:() async{
                  if(_formKey.currentState.validate())
                  {
                    print(email);
                    print(password);
                    setState(()=> loading = true);
                   dynamic result = await _auth.registerwithEmailandPassword(email, password, name, phone);
                    if(result == null)
                    {
                      setState((){
                        error='Data user already exist or you pass wrong email';
                        loading = false;
                      });
                    }
                  }
                } ,
               ),
               SizedBox(height: 12),
               Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14),
               ),
               SizedBox(height: 20),
               _buildSignInBtn(),
            ],
          ),
        ),
        ),
      ),
    );
  }

  Widget _buildSignInBtn() {
    return GestureDetector(
      onTap:(){
        widget.toogleView();
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Have an Account? ',
              style: TextStyle(
                color: Color(0xFF393939),
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign in',
              style: TextStyle(
                color: Color(0xFF393939),
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

 Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            validator: (val)=> val.isEmpty || val.isValidEmail()==false ? "Enter valid email" : null,
            onChanged: (val){
              setState(()=>email=val);
            },
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Color(0xFF393939),
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Color(0xFF393939),
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

 Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(                                        
            validator: (val)=> val.length <6 ? "Enter a password 6+" : null,        
            onChanged: (val){
              setState(()=>password=val);
            },
            obscureText: true,
            style: TextStyle(
              color: Color(0xFF393939),
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Color(0xFF393939),
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Confirm Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
            child: TextFormField(                                        
            validator: (val)=> val!=password ? "Password does not match" : null, 
            obscureText: true,
            style: TextStyle(
              color: Color(0xFF393939),
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Color(0xFF393939),
              ),
              hintText: 'Confirm Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

   Widget _buildNameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Name',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            validator: (val)=> val.isEmpty? "Enter Name" : null,
            onChanged: (val){
              setState(()=>name=val);
            },
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Color(0xFF393939),
              fontFamily: 'OpenSans',
            ),
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
        ),
      ],
    );
  }

  Widget _buildPhoneTF() {
   return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Phone',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            validator: (val)=> val.isEmpty || val.isPhoneValid()==false ? "Enter valid phone" : null,
            onChanged: (val){
              setState(()=>phone=val);
            },
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Color(0xFF393939),
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.phone,
                color: Color(0xFF393939),
              ),
              hintText: 'Enter your Phone',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }


}




/*
class _SignUpScreenState extends State<SignUpScreen> {
  bool _rememberMe = false;

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email ='';
  String password = '';
  String error='';

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          //key: _formKey,
          child: TextField(
            //validator: (val)=> val.isEmpty ? "Enter an email" : null,
            onChanged: (val){
              setState(()=>email=val);
            },
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Color(0xFF393939),
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Color(0xFF393939),
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
        //  key: _formKey,
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(                                         /////////////////////////zmiana poszla
            validator: (val)=> val.length <6 ? "Enter a password 6+" : null,        ////////////tu tez
            onChanged: (val){
              setState(()=>password=val);
            },
            obscureText: true,
            style: TextStyle(
              color: Color(0xFF393939),
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Color(0xFF393939),
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Confirm Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            obscureText: true,
            style: TextStyle(
              color: Color(0xFF393939),
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Color(0xFF393939),
              ),
              hintText: 'Confirm Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Name',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            obscureText: true,
            style: TextStyle(
              color: Color(0xFF393939),
              fontFamily: 'OpenSans',
            ),
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
        ),
      ],
    );
  }

  Widget _buildPhoneTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Phone',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            obscureText: true,
            style: TextStyle(
              color: Color(0xFF393939),
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.phone,
                color: Color(0xFF393939),
              ),
              hintText: 'Enter your Phone Number',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildRegisterBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async{
          print('Register Button Pressed');                                                             ////////TTTT
          //if(_formKey.currentState.validate()){
            print(email);
            print(password);
            dynamic result = await _auth.registerwithEmailandPassword(email, password);
            if(result == null)
            {
              setState(()=>error='please supply a valid email');
            }
          //}
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Color(0xFFFDFDFD),
        child: Text(
          'REGISTER',
          style: TextStyle(
            color: Color(0xFFECB6B6),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }


  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- OR -',
          style: TextStyle(
            color: Color(0xFF393939),
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          'Sign in with',
          style: kLabelStyle,
        ),
      ],
    );
  }

  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFFDFDFD),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }


  Widget _buildSignInBtn() {
    return GestureDetector(
      onTap:(){
        widget.toogleView();
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Have an Account? ',
              style: TextStyle(
                color: Color(0xFF393939),
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign in',
              style: TextStyle(
                color: Color(0xFF393939),
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                // decoration: BoxDecoration(
                /*gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFEAA5EC),
                      Color(0xFFE9C1EC),
                      Color(0xFFE3CAE5),
                      Color(0xFFE6E0E7),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),

                   */
                //),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/tlo.jpeg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                   // key: _formKey,                                    //////dodane
                    children: <Widget>[
                      Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Color(0xFF393939),
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      _buildNameTF(),
                      SizedBox(height: 30.0),
                      _buildPhoneTF(),
                      SizedBox(height: 30.0),
                      _buildEmailTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildPasswordTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildConfirmPasswordTF(),
                      SizedBox(height: 20.0),
                      _buildRegisterBtn(),
                      _buildSignInBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}*/