import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:app/models/debate.dart';
import 'package:app/services/debate_service.dart';

class AddContribution extends StatefulWidget {

  Debate _debate;
  Author _author;
  int _minValue;
  int _maxValue;

  AddContribution({
    @required Debate debate,
    @required Author author,
    @required int minValue,
    @required int maxValue,
  }){
    _debate = debate;
    _author = author;
    _minValue = minValue;
    _maxValue = maxValue;
  }

  @override
  State<StatefulWidget> createState() {
    return _AddContribution(
      debate: _debate,
      author: _author,
      minValue: _minValue, 
      maxValue: _maxValue
    );
  }
}

class _AddContribution extends State<AddContribution> {
  
  Debate _debate;
  int _minValue;
  int _maxValue;
  int _minutes;
  Author _author;
  String _messageTitle;

  _AddContribution({
    Debate debate,
    int minValue, 
    int maxValue,
    Author author}) {
    _debate = debate;
    _author = author;
    _minValue = minValue;
    _maxValue = maxValue;

    if(_maxValue != null) {
      _minutes = (_maxValue/2).round();
    }
    else {
      _minutes = 1;
    }
  }

  void _pushThisValuesToDatabase() {
    DebateService.createContribution(
      _debate.debateCode, 
      _messageTitle, 
      _author, 
      _minutes
    );
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Wortmeldung hinzufügen...'),
      titlePadding: EdgeInsets.fromLTRB(12, 12, 12, 12),
      contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 12),
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Meldetitel',
          ),
          onChanged: (messageTitle) => 
            setState(() => _messageTitle = messageTitle),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(12, 20, 12, 12),
          child: Text('Geschätzte Redezeit eingeben...', textScaleFactor: 1.2),
        ),
        Row(
          children: <Widget>[
            NumberPicker.integer(
              initialValue: _minutes,
              minValue: _minValue ?? 1,
              maxValue: _maxValue ?? 999,
              onChanged: (currentNumber) => 
                setState(() => _minutes = currentNumber),
            ),
            Text('Minuten')
          ],
        ),
        IconButton(
          icon: Icon(Icons.check),
          onPressed: () => {
            _pushThisValuesToDatabase,
            Navigator.of(context).pop()
          },
        ),
      ],
    );
  }
}