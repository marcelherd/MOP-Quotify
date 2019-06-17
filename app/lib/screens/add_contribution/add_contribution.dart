import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:app/screens/session/session_arguments.dart';
import 'package:app/services/debate_service.dart';

class AddContribution extends StatefulWidget {
  static const routeName = '/AddContribution';

  AddContribution({Key key}) : super(key: key);

  _AddContributionState createState() => _AddContributionState();
}

class _AddContributionState extends State<AddContribution> {

  final _contentController = TextEditingController();
  final _durationController = TextEditingController();

  void _onPressConfirm() {
    final SessionArguments args = ModalRoute.of(context).settings.arguments;
    var debateCode = args.debate.debateCode;
    var author = args.author;
    var content = _contentController.text;
    var duration = num.tryParse(_durationController.text);

    if (content.isEmpty) {
      Fluttertoast.showToast(
        msg: "Es wurde keine Beschreibung vergeben!",
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 2);
      return;
    }

    if (duration == null) {
      Fluttertoast.showToast(
        msg: "Es wurde keine Dauer vergeben!",
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 2);
      return;
    }

    DebateService.createContribution(debateCode, content, author, duration * 60);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wortmeldung anlegen'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Beschreibung',
                helperText: 'Kurze Beschreibung der Wortmeldung'
              ),
            ),
            SizedBox(height: 24),
            TextField(
              controller: _durationController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Dauer',
                helperText: 'Grob geschätze Dauer der Wortmeldung in Minuten'
              ),
            ),
          ],
        ),
      ),
      persistentFooterButtons: <Widget>[
        FlatButton(
          child: Text('Abbrechen'),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: Text('Bestätigen'),
          onPressed: _onPressConfirm,
        ),
      ],
    );
  }
}