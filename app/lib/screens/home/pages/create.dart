import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:app/services/debate_service.dart';
import 'package:app/screens/session/index.dart';
import 'package:app/screens/add_property/index.dart';
import 'package:app/models/property.dart';

class CreateScreen extends StatefulWidget {

  @override
  _CreateState createState() => _CreateState();

}

class _CreateState extends State<CreateScreen> {

  final _inputController = TextEditingController();
  String _errorText;
  
  final properties = List<Property>();

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _onPressedCreate() {
    var topic = _inputController.text;

    if (topic.isEmpty) {
      Fluttertoast.showToast(
        msg: "Es wurde kein Thema vergeben!",
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 2);
      return;
    }

    var debate = DebateService.createDebate(topic, properties);
    var arguments = SessionArguments(debate);
    Navigator.pushNamed(context, Session.routeName, arguments: arguments);
  }

  void _onPressedAddProperty([Property property]) async {
    var result = await Navigator.pushNamed(context, AddProperty.routeName, arguments: property) as Property;

    if (result != null) {
      var index = properties.indexWhere((p) => p.title == result.title);

      if (index == -1) { // new property
        properties.add(result);
      } else { // update property
        properties.removeWhere((p) => p.title == result.title);
        properties.insert(index, result);
      }
    }
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
                labelText: 'Thema',
              ),
            ),
            Column(
              children: properties.map<Widget>((Property property) {
                return FlatButton(
                  child: Text(property.title),
                  onPressed: () => _onPressedAddProperty(property),
                );
              }).toList(),
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: _onPressedAddProperty,
            )
          ],
        ),
      ),
      persistentFooterButtons: <Widget>[
        FlatButton(
          child: Text('Erstellen'),
          onPressed: _onPressedCreate,
        ),
      ],
    );
  }
}
