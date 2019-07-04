import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../util/utils.dart' as util;


class klimatic extends StatefulWidget {
  @override
  _klimaticState createState() => _klimaticState();
}

class _klimaticState extends State<klimatic> {

  void showStuff() async {
    Map data = await getWeather(util.apiId,util.defaultCity );
    print(data.toString());
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text('klimatic'),
        backgroundColor: Colors.redAccent,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.menu, color: Colors.white),
              onPressed: showStuff
          )
        ],
      ),
      body: new Stack(
        children: <Widget>[
          new Center(
            child: new Image.asset(
              'images/umbrella2.jpg',
              height: 770.0,
              width: 490.0,
              fit: BoxFit.fill,
            ),
          ),
          new Container(
            alignment: Alignment.topRight,
            margin: const EdgeInsets.fromLTRB(0.0, 10.9, 20.9, 0.0),
            child: new Text(
              'Spokane',
              style: cityStyle(),
            ),
          ),
          new Container(
            alignment: Alignment.center,
            child: new Image.asset('images/light_rain.png'),
          ),
          //container which will have our weather data
          new Container(
            margin: const EdgeInsets.fromLTRB(30.0, 290.0, 0.0, 0.0),
            alignment: Alignment.center,
            child: new Text('67.8 C', style: tempStyle()),
          )
        ],
      ),
    );
  }
       Future<Map> getWeather( String appID, String cityID) async{
//    String apiURl ='https://api.openweathermap.org/data/2.5/weather?id=$cityID&appid=${util.apiId}&units=metric';
    String apiURl ='https://api.openweathermap.org/data/2.5/weather?q=$cityID,bo&appid=${util.apiId}&units=metric';

    http.Response response = await http.get(apiURl);

      return json.decode(response.body);
       }

}


TextStyle cityStyle() {
  return new TextStyle(
      color: Colors.blueAccent, fontSize: 22.9, fontStyle: FontStyle.italic);
}

TextStyle tempStyle() {
  return new TextStyle(
      color: Colors.white,
      fontSize: 48.9,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w500);
}
