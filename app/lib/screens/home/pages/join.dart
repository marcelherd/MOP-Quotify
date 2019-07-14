import 'dart:async';

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:app/services/debate_service.dart';
import 'package:app/screens/registration/index.dart';

class JoinScreen extends StatefulWidget {

  @override
  _JoinState createState() => _JoinState();

}

class _JoinState extends State<JoinScreen> {

  final _inputController = TextEditingController();

  var _doesValidate = false;
  var _firstTapBack = false;

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _inputController.addListener(_onValueChanged);
  }

  void _onValueChanged() {
    setState(() => this._doesValidate = _inputController.text.length == 6);
  }

  void _onPressJoin() async {
    var debate = await DebateService.getDebate(_inputController.text.toUpperCase());

    if (debate == null || debate.closed) {
      Fluttertoast.showToast(
        msg: "Die Debatte existiert nicht!",
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 2);
      return;
    }

    Navigator.pushNamed(context, Registration.routeName, arguments: debate);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  'Debatte beitreten',
                  style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _inputController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Redecode',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Beitreten', style: TextStyle(color: Colors.white)),
                      color: Theme.of(context).primaryColor,
                      onPressed: _doesValidate ? _onPressJoin : null,
                  ),
                  ],
                )
              ]
            ),
          ),
        ),
      ),
      onWillPop: () {
        if(!_firstTapBack){
          _firstTapBack = true;
          new Timer(const Duration(seconds: 2), () {
            _firstTapBack = false;
          });
          Fluttertoast.showToast(
            msg: "Zweimaliges tippen beendet die App.",
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 2);
          return new Future(() => false);
        }else{
          return new Future(() => true);
        }
      },
    );
  }
}
