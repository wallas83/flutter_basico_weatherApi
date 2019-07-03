
import 'package:flutter/material.dart';

class klimatic extends StatefulWidget {
  @override
  _klimaticState createState() => _klimaticState();
}

class _klimaticState extends State<klimatic> {
  @override
  Widget build(BuildContext context) {
    return new  Scaffold(

      appBar: new AppBar(

        centerTitle: true,
        title: new Text('klimatic'),
        backgroundColor: Colors.redAccent,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.menu, color: Colors.white),
            onPressed: ()=> debugPrint("hey")
          )
        ],
      ),
      body: new Stack(
        children: <Widget>[
          new Center(
            child: new Image.asset('images/umbrella2.jpg', height: 770.0, width: 490.0,
            fit: BoxFit.fill,),
          ),
          new Container(
            alignment: Alignment.topRight,
            margin: const EdgeInsets.fromLTRB(0.0, 10.9, 20.9, 0.0),
            child: new Text('Spokane', style:  cityStyle(),),
          )

        ],
      ),
    );
  }
}

TextStyle cityStyle(){
  return new TextStyle(
    color: Colors.blueAccent,
    fontSize: 22.9,
    fontStyle: FontStyle.italic
  );
}