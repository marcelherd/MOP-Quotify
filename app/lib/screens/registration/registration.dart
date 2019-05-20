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
  Map<String, dynamic> customChoices = Map<String, dynamic>();


  _RegistrationState(){
    
    final Debate debate = ModalRoute.of(context).settings.arguments;
    debate.customProperties.forEach((k, v) {
      if(v.length > 0){
        customChoices[k.toString()] = v[0].toString();
      }else{
        customChoices[k.toString()] = false;
      }
    });
  }
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
    var author = Author(name, getGender(_gender), customChoices);
    DebateService.createAuthor(debate.debateCode, author);
    SessionArguments arguments = SessionArguments(debate, author);
    Navigator.pushReplacementNamed(context, Session.routeName, arguments: arguments);
  }

  void updateCustomChoices(String key, dynamic value){
    setState((){
      customChoices[key] = value;
    });
  }

  List<Widget> _buildCustomPropsUI() {
    var widgets = List<Widget>();

    final Debate debate = ModalRoute.of(context).settings.arguments;
    debate.customProperties.forEach((k, v) {
      List<String> values = [];
      v.forEach((value){
        values.add(value.toString());
      });
      Widget valueSide;
      if(values.length > 0){
        valueSide =           
        DropdownButton<String>(
          value: customChoices[k.toString()].toString(),
          onChanged: (String newValue) {updateCustomChoices(k, newValue);},
          items: values
              .map<DropdownMenuItem<String>>(
                  (String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        );

      }else{
        valueSide = Checkbox(
          value: customChoices[k.toString()],
          onChanged: (bool newValue) {updateCustomChoices(k, newValue);},
        );
      }
        widgets.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Text(k),
          SizedBox(width: 64,),
          valueSide
        ],));
    });

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    final Debate debate = ModalRoute.of(context).settings.arguments;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Geschlecht"),
                SizedBox(width: 64,),
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
              ],
            )

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
