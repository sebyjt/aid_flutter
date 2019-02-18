import 'dart:async';
import 'Login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Home.dart';
void main() => runApp(MaterialApp(home:Splash(),debugShowCheckedModeBanner: false,));

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
  
}

class _SplashState extends State<Splash> {
  SharedPreferences preferences;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(milliseconds: 2000),getPrefs);
  }
  Future getPrefs() async
  {
    preferences=await SharedPreferences.getInstance();

    if(preferences.getString("user")==null)
    {
      preferences.setBool("firstsignin", true);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>new Login()));
    }
    else
    {
      if(preferences.getKeys().contains("firstsignin"))
        {
          preferences.remove("firstsignin");
        }
      Navigator.push(context, MaterialPageRoute(builder: (context)=>new Home()));

    }
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
