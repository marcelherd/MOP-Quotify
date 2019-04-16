import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:app/screens/debate/index.dart';

class JoinScreen extends StatefulWidget {

  @override
  _JoinState createState() => _JoinState();

}

class _JoinState extends State<JoinScreen> {

  final _inputController = TextEditingController();

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

  void _onPressJoin() {
    final debateCode = _inputController.text;

    Firestore.instance.collection(debateCode).getDocuments().then((QuerySnapshot snapshot) {
      if (snapshot.documents.isEmpty) {
        // TODO(marcelherd): Error in snackbar? or InputDecoration.errorText?
        debugPrint('Debate with code $debateCode does not exist');
        return;
      }

      // TODO(marcelherd): Since both create and join already have to load the document to check for existance
      // it makes more sense to pass in the loaded document as argument rather than loading it again

      Navigator.pushNamed(context, Debate.routeName, arguments: DebateArguments(debateCode: debateCode));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
        child: Column(
          children: <Widget>[
            Text(
              'Debatte betreten',
              style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _inputController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Redecode',
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
