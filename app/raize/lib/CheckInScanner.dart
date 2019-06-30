import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:raize/QRScanAPI.dart';
import 'package:simple_permissions/simple_permissions.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _reader = '';
  Color _resultColor;
  Permission permission = Permission.Camera;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Scanner"),
        ),
        body: new Column(
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
            ),
            new RaisedButton(
              child: new Text(
                "Check In",
                style: new TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              onPressed: scan,
            ),
            new Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
            ),
            new Text(
              '$_reader',
              softWrap: true,
              style: new TextStyle(fontSize: 20.0, color: _resultColor ),
            ),
          ],
        ),
      ),
    );
  }

  requestPermission() async {
    PermissionStatus result =
        await SimplePermissions.requestPermission(permission);
    setState(
      () => new SnackBar(
            backgroundColor: Colors.red,
            content: new Text(" $result"),
          ),
    );
  }

  scan() async {
    try {
      String reader = await BarcodeScanner.scan();

      if (!mounted) {
        return;
      }

      bool userAuthenticated = await QRScanAPI.checkIn(reader);

      setState(() => showScanResults(userAuthenticated));
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        requestPermission();
      } else {
        setState(() => _reader = "unknown exception $e");
      }
    } on FormatException {
      setState(() => _reader =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => _reader = 'Unknown error: $e');
    }
  }

  showScanResults(bool userAuthenticated) {
    if (userAuthenticated) {
      this._reader = "Approved..";
      this._resultColor = Colors.green;
    } else {
      this._reader = "Please contact event orgnaizer!";
      this._resultColor = Colors.red;
    }
  }
}
