import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var pData={};
  var percent;
  SharedPreferences preferences;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadPersonalData();
    loadNGO();
  }
  Future loadPersonalData() async{
    preferences=await SharedPreferences.getInstance();
    if(preferences.getKeys().contains("firstsignin"))
    {
      percent="25";
      var data={"Username":preferences.getString("user"),"Percentage":percent};
      print(data);
      String url="https://6ghfrrqsb3.execute-api.ap-south-1.amazonaws.com/Dev/userdetails/setpercentage";

      var response=await getData(url,json.encode(data));
      pData={};
      pData=response;
      print(pData);
    }
    else{
      var data={"Username":preferences.getString("user")};
      String url="https://6ghfrrqsb3.execute-api.ap-south-1.amazonaws.com/Dev/userdetails";
      var response=await getData(url,json.encode(data));
      pData={};
      pData=response["Data"];
      print(pData);

    }
    setState(() {
      pData;
    });
  }
  Future loadNGO() async{

  }
  Future<Map> getData(var url,var data) async
  {
    http.Response response=await http.post(url,body: data);
    return json.decode(response.body);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Padding(child:Text("Home",style: TextStyle(
              color: Color(0xff066AA6),

              fontSize: 30.0,
          fontWeight: FontWeight.bold)),padding: EdgeInsets.only(left: 20.0,top: 25.0),),
          new Expanded(
            flex: 2,
              child: ListView.builder(
            itemBuilder: (context, i) => new Container(
                width: 200.0,
                padding: EdgeInsets.only(right: 23.0,bottom: 5.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  elevation: 5.0,
                  color: Color(0xff066AA6),
                  child: (!pData.isEmpty)?
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Expanded(
                          flex: 2,
                          child: Center(
                              child: Text(
                           pData.keys.toList()[i],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ))),
                      new Expanded(
                          flex: 4,
                          child: Center(
                              child: Text(
                                pData[pData.keys.toList()[i]],

                                style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold),
                          ))),
                    ],
                  ):
                  Center(
                    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),),
                  ),
                )),
            itemCount:(pData.isEmpty)? 5:pData.length,
            padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
            scrollDirection: Axis.horizontal,
          )),
          new Expanded(
            child: Container(),
            flex:7,
          )
        ],
      ),
    ));
  }
}
