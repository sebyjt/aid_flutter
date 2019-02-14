import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("Assets/bg.png"), fit: BoxFit.fill)),
      child: new Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
        Image.asset(
          "Assets/Logo.png",
          width: 200.0,
          height: 100.0,
        ),
                Padding(padding: EdgeInsets.only(top: 50.0,bottom: 10.0,left: 20.0,right: 20.0),
                                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Username"
                    ),
                  ),
                ),
        Padding(padding: EdgeInsets.only(top:10.0,bottom: 10.0,left: 20.0,right: 20.0),
                                  child: TextField(
                                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
              
                    ),
                  ),
                ),
        Padding(padding: EdgeInsets.only(top: 30.0,left: 20.0,right: 20.0),
          child: Image.asset("Assets/Button.png"))
              ])),
    ));
  }
}
