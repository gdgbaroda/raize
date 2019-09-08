import 'package:flutter/material.dart';

import 'api/api_manager.dart';

enum VerificationState { VERIFYING, VERIFIED, INVALID }

class QRScanState extends StatefulWidget {
  static String tag = 'qr-scan-state-screen';
  String qrData;

  QRScanState({@required this.qrData});

  @override
  _QRScanState createState() => _QRScanState(qrData: qrData);
}

class _QRScanState extends State<QRScanState> {
  VerificationState state = VerificationState.VERIFYING;
  String qrData;

  _QRScanState({@required this.qrData});

  @override
  Future initState() {
    super.initState();
    _setState(VerificationState.VERIFYING);

    APIManager.validateUser(qrData).then((userAuthenticated) {
      print("$qrData and $userAuthenticated");
      if (userAuthenticated) {
        _setState(VerificationState.VERIFIED);
      } else {
        _setState(VerificationState.INVALID);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _createBody());
  }

  void _setState(state) {
    setState(() {
      this.state = state;
    });
  }

  Widget _createBody() {
    switch (state) {
      case VerificationState.VERIFYING:
        return _createVerifyingStateWidget();

      case VerificationState.VERIFIED:
        return _createVerifiedStateWidget();

      case VerificationState.INVALID:
        return _createInvalidStateWidget();

      default:
        return _createVerifyingStateWidget();
    }
  }

  Widget _createVerifyingStateWidget() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _createVerifiedStateWidget() {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Icon(
            Icons.check,
            size: 50,
            color: Colors.green,
          ),
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: Text("Verified!",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.green,
                    fontWeight: FontWeight.bold)),
          )
        ]));
  }

  Widget _createInvalidStateWidget() {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Icon(
            Icons.close,
            size: 50,
            color: Colors.red,
          ),
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: Text("Invalid Coupon!",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.red,
                    fontWeight: FontWeight.bold)),
          )
        ]));
  }
}
