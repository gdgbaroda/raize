import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:simple_permissions/simple_permissions.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _reader='';
  Permission permission= Permission.Camera;
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.pinkAccent,
      home:new Scaffold(
        appBar: new AppBar(title: new Text("Scanner"),backgroundColor: Colors.orange,),
        body: new Column(
          children: <Widget>[

            new Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
            ),
            new RaisedButton(

              splashColor: Colors.pinkAccent,
              color: Colors.red,
              child: new Text("Scan",style: new TextStyle(fontSize: 20.0,color: Colors.white),),
              onPressed: scan,
            ),
            new Padding(padding: const EdgeInsets.symmetric(vertical: 10.0), ),
            new Text('$_reader',softWrap: true, style: new TextStyle(fontSize: 30.0,color: Colors.blue),),

          ],
        ),
      ),
    );
  }



  requestPermission() async {
    PermissionStatus result = await SimplePermissions.requestPermission(permission);
    setState(()=> new SnackBar
      (backgroundColor: Colors.red,content: new Text(" $result"),),

    );
  }
  scan() async {
    try {
      String reader= await BarcodeScanner.scan();

      if (!mounted) {
        return;
      }

      setState(() => this._reader=reader);
    } on PlatformException catch(e) {
      if(e.code==BarcodeScanner.CameraAccessDenied) {requestPermission();}
      else{setState(()=> _reader = "unknown exception $e");}
    }on FormatException{
      setState(() => _reader = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => _reader = 'Unknown error: $e');
    }

  }

}
