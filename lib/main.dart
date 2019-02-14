import 'dart:async';
import 'Login.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home:Splash(),debugShowCheckedModeBanner: false,));

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
  
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(milliseconds: 2000),()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>new Login())));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("Assets/bg.png"),fit: BoxFit.fill)
      ),
      child: new Center(
        child: Image.asset("Assets/Logo.png",width: 200.0,height: 100.0,),
      ),
    );
  }
}
