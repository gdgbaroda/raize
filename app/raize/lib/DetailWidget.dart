import 'package:flutter/material.dart';

class DetailWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return   new Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Image(image: new AssetImage('assets/person.jpeg'),height: 150,width: 150,fit: BoxFit.fill,),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Text(" GDG Baroda Co- routine",style: TextStyle(fontSize: 20),),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Text("23rd july ",style: TextStyle(fontSize: 20),),
        )
        ,
        RaisedButton(
          textColor: Colors.blue,

          child: new Text("Navigation",textAlign: TextAlign.center,),
          onPressed: () {},
        ),

        RaisedButton(
          textColor: Colors.blue,
          child: new Text("Check In"),
          onPressed: () {},
        ),
      ],
    );
  }
}


