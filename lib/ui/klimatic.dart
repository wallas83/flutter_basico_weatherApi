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

  String _cityEntered;

  Future _goToNextScrean(BuildContext context) async {
    Map results = await Navigator.of(context)
        .push(new MaterialPageRoute<Map>(builder: (BuildContext context) {
      return new ChangeCity();
    }));
    if(results != null && results.containsKey('enter')){
      _cityEntered = results['enter'];

    }
  }

  void showStuff() async {
    Map data = await getWeather(util.apiId, util.defaultCity);
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
              onPressed: () => _goToNextScrean(context))
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
              '${_cityEntered == null ? util.defaultCity : _cityEntered}',
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
            child: updateTemWidget('$_cityEntered'),
          )
        ],
      ),
    );
  }

  Future<Map> getWeather(String appID, String cityID) async {
//    String apiURl ='https://api.openweathermap.org/data/2.5/weather?id=$cityID&appid=${util.apiId}&units=metric';
    String apiURl =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityID&appid=${util.apiId}&units=metric';

    http.Response response = await http.get(apiURl);

    return json.decode(response.body);
  }

  Widget updateTemWidget(String city) {
    return new FutureBuilder(
        future: getWeather(util.apiId, city == null ? util.defaultCity : city),
        builder: (BuildContext context, AsyncSnapshot<Map> Snapshot) {
          //where  we get all of the info data, we setup widgets etc.
          if (Snapshot.hasData) {
            Map content = Snapshot.data;
            print(content);
            return new Container(
              margin: const EdgeInsets.fromLTRB(15.0, 150.0, 0.0, 0),
              child: new Column(
                children: <Widget>[
                  new ListTile(
                    title: new Text(content['main']['temp'].toString() +" c",
                        style: new TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 48.9,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500)),
                    subtitle: new ListTile(

                      title: new Text(

                        "Humidity: ${content['main']['humidity'].toString()}\n"
                            "Min: ${content['main']['temp_min'].toString()} c\n"
                            "Max: ${content['main']['temp_max'].toString()} c",
                        style:extraData(),


                      ),
                    ),
                  ),
                  new Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(15.0, 0.9, 200.9, 50.0),
                    child: new Text(
                      '${content['sys']['country']}',
                      style: cityStyle(),
                    ),
                  )

                ],
              ),
            );
          } else {
            return new Container();
          }
        });
  }
}

class ChangeCity extends StatelessWidget {
  var _cityFieldController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('change city'),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
      ),
      body: new Stack(
        children: <Widget>[
          new Center(
            child: new Image.asset(
              'images/white_snow.png',
              width: 390.0,
              height: 800.0,
              fit: BoxFit.fill,
            ),
          ),
          new ListView(
            children: <Widget>[
              new ListTile(
                title: new TextField(
                  decoration: new InputDecoration(hintText: 'Enter City'),
                  controller: _cityFieldController,
                  keyboardType: TextInputType.text,
                ),
              ),
              new ListTile(
                title: new FlatButton(
                  onPressed: (){
                    Navigator.pop(context, {
                      'enter': _cityFieldController.text
                    });
                  },
                  child: new Text('Get Weather'),
                  textColor: Colors.white70,
                  color: Colors.redAccent,
                ),
              )
            ],
          )
        ],
      ),
    );
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

TextStyle extraData(){
  return new TextStyle(
  color: Colors.white,
  fontSize: 20.9,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w600);
}
