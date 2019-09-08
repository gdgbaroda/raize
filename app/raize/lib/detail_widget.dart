import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:raize/qr_scan_state.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models/event_model.dart';

class DetailWidget extends StatefulWidget {
  final EventModel eventModel;


  DetailWidget({@required this.eventModel});
  @override
  _MyAppState createState() => new _MyAppState(eventModel);
}

class _MyAppState extends State<DetailWidget> {
  EventModel eventModel;
  _MyAppState(EventModel eventModel) {
    this.eventModel = eventModel;
  }

  String _reader = '';
  Color _resultColor;
  Permission permission = Permission.Camera;

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Image.network(
          eventModel.banner,
          height: 150,
          width: double.infinity,
          fit: BoxFit.fitWidth,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: new Text(
            eventModel.description,
            style: TextStyle(fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: new Text(
            eventModel.duration.start.date,
            style: TextStyle(fontSize: 20),
          ),
        ),
        const SizedBox(height: 90.0),
        new Container(
          alignment: Alignment.bottomCenter,
          child: new SizedBox(
            width: 350.0,
            height: 50.0,
            child: new RaisedButton(
              child: new Text('Navigation'),
              onPressed: _launchMapsUrl,
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        new Container(
          alignment: Alignment.bottomCenter,
          child: new SizedBox(
            width: 350.0,
            height: 50.0,
            child: new RaisedButton(
              child: new Text('Check In'),
              onPressed: scan,
            ),
          ),
        ),
        const SizedBox(height: 30.0),
        new Container(
        child : new Row(
          children: <Widget>[
            new Text(
              '$_reader',
              softWrap: true,
              style: new TextStyle(fontSize: 20.0, color: _resultColor),
            ),

          ],
        ),
        )
      ],
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
      String qrData = await BarcodeScanner.scan();

      if (!mounted) {
        return;
      }
      print("scan result: $qrData");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QRScanState(qrData: qrData),
        ),
      );
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        requestPermission();
      } else {
        setState(() => _reader = "unknown exception $e");
      }
    } on FormatException {
      setState(() => () => new SnackBar(
            backgroundColor: Colors.red,
            content: new Text("Scan Cancelled!"),
          ));
    } catch (e) {
      setState(() => _reader = 'Unknown error: $e');
    }
  }


  _launchMapsUrl() async {
    final url = 'https://goo.gl/maps/3D42ABqcuTG6t9kLA';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
