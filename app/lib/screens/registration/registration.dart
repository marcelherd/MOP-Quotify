import 'package:flutter/material.dart';

import 'package:app/models/debate.dart';
import 'package:app/screens/session/index.dart';

class Registration extends StatefulWidget {
  static const routeName = '/Registration';

  Registration({Key key}) : super(key: key);

  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _nameController = TextEditingController();
  String _errorText;
  String _gender = 'male';

  void _onPressJoin() {
    var name = _nameController.text;

    if (name.isEmpty) {
      setState(() => _errorText = 'Es wurde kein Name vergeben!');
      return;
    }

    final Debate debate = ModalRoute.of(context).settings.arguments;
    var author = Author(name, getGender(_gender)); // TODO(marcelherd): Pass custom properties
    SessionArguments arguments = SessionArguments(debate, author);
    Navigator.pushNamed(context, Session.routeName, arguments: arguments);
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
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Name',
                      errorText: _errorText,
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                DropdownButtonHideUnderline(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.purple),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                    ),
                    child: DropdownButton<String>( // TODO(marcelherd): Use Gender enum instead
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
                  ),
                ),
              ],
            ),
          ],
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
