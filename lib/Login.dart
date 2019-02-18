import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController username,password;
  GlobalKey<ScaffoldState> key=new GlobalKey();
  SharedPreferences preferences;
  @override
  void initState()  {
    // TODO: implement initState
    getPrefs();

    super.initState();
    username=new TextEditingController();
    password=new TextEditingController();

  }
Future getPrefs() async {
    preferences=await SharedPreferences.getInstance();
}
  Future login() async{
    var data={"username":username.text,"password":password.text};
    var response = await post("https://6ghfrrqsb3.execute-api.ap-south-1.amazonaws.com/Dev/login",json.encode(data));
    print(response);
    if(response["message"]=="Success")
    {
      preferences.setString("user", response["type"]);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>new Home()));
    }
    else{
      key.currentState.showSnackBar(new SnackBar(content: new Text("wrong credentials"),backgroundColor: Colors.green, ));
      print("error");
    }
  }
  Future<Map> post(var url,var data) async{
    http.Response response=await http.post(url,body: data);
    return json.decode(response.body);
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
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
                        controller: username,
                        decoration: InputDecoration(
                            hintText: "Username"
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top:10.0,bottom: 10.0,left: 20.0,right: 20.0),
                      child: TextField(
                        controller: password,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",

                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: login,
                      child: Padding(padding: EdgeInsets.only(top: 30.0,left: 20.0,right: 20.0),
                          child: Image.asset("Assets/Button.png")),
                    )
                  ])),
        ));
  }
}
