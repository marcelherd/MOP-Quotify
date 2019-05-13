import 'package:app/services/debate_service.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:app/models/debate.dart';
import 'package:app/screens/session/index.dart';

class Registration extends StatefulWidget {
  static const routeName = '/Registration';

  Registration({Key key}) : super(key: key);

  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _nameController = TextEditingController();
  String _gender = 'male';

  void _onPressJoin() {
    var name = _nameController.text;

    if (name.isEmpty) {
      Fluttertoast.showToast(
        msg: "Es wurde kein Name vergeben!",
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 2);
      return;
    }

    final Debate debate = ModalRoute.of(context).settings.arguments;
    var author = Author(name, getGender(_gender)); // TODO(marcelherd): Pass custom properties
    DebateService.createAuthor(debate.debateCode, author);
    SessionArguments arguments = SessionArguments(debate, author);
    Navigator.pushNamed(context, Session.routeName, arguments: arguments);
  }

  List<Widget> _buildCustomPropsUI() {
    var widgets = List<Widget>();

    final Debate debate = ModalRoute.of(context).settings.arguments;
    debate.customProperties.forEach((k, v) {
      // TODO(marcelherd): build UI
    });

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrierung'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              // TODO(marcelherd): Use Gender enum instead
              value: _gender,
              onChanged: (String newValue) =>
                  setState(() => _gender = newValue),
              items: <String>['male', 'female', 'diverse']
                  .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ))
                  .toList(),
            ),
          ]..addAll(_buildCustomPropsUI()),
        ),
      ),
      persistentFooterButtons: <Widget>[
        FlatButton(
          child: Text('Abbrechen'),
          onPressed: () {},
        ),
        FlatButton(
          child: Text('Beitreten'),
          onPressed: _onPressJoin,
        ),
      ],
    );
  }
}
