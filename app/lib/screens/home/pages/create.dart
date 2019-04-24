import 'package:flutter/material.dart';

import 'package:app/services/debate_service.dart';
import 'package:app/screens/session/index.dart';

class CreateScreen extends StatefulWidget {

  @override
  _CreateState createState() => _CreateState();

}

class _CreateState extends State<CreateScreen> {

  final _inputController = TextEditingController();
  String _errorText;

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _onPressCreate() async {
    var debateCode = _inputController.text;

    if (debateCode.isEmpty) {
      setState(() => _errorText = 'Es wurde kein Thema vergeben!');
      return;
    }

    var customProperties = <String, dynamic>{}; // TODO(marcelherd): Fill these from UI
    var debate = DebateService.createDebate(debateCode, customProperties);
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
              'Debatte erstellen',
              style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _inputController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Thema',
                errorText: _errorText,
              ),
            ),
          ],
        ),
      ),
      persistentFooterButtons: <Widget>[
        FlatButton(
          child: Text('Erstellen'),
          onPressed: _onPressCreate,
        )
      ],
    );
  }
}
