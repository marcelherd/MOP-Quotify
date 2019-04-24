import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:app/models/debate.dart';
import 'package:app/services/debate_service.dart';
import 'package:app/screens/session/index.dart';

class JoinScreen extends StatefulWidget {

  @override
  _JoinState createState() => _JoinState();

}

class _JoinState extends State<JoinScreen> {

  final _inputController = TextEditingController();
  String _errorText;

  var _doesValidate = false;

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
    setState(() => this._doesValidate = _inputController.text.isNotEmpty);
  }

  void _onPressJoin() async {
    var debate = await DebateService.getDebate(_inputController.text);

    if (debate == null) {
      setState(() => _errorText = 'Diese Debatte existiert nicht!');
      return;
    }

    Navigator.pushNamed(context, Session.routeName, arguments: debate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
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
                hintText: 'Redecode',
                errorText: _errorText,
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
          ],
        ),
      ),
    );
  }
}
