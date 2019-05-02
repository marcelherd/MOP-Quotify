import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'minutes_Picker.dart';

class AddContribution extends StatefulWidget {

  int _minValue;
  int _maxValue;

  AddContribution({
    @required int minValue,
    @required int maxValue,
  }){
    _minValue = minValue;
    _maxValue = maxValue;
  }

  @override
  State<StatefulWidget> createState() {
    return _AddContribution(
      minValue: _minValue, 
      maxValue: _maxValue
    );
  }
}

class _AddContribution extends State<AddContribution> {
  
  int _minValue;
  int _maxValue;
  int _minutes;
  String _author;
  String _messageTitle;

  _AddContribution({
    int minValue, 
    int maxValue,
    String author}) {
    _minValue = minValue;
    _maxValue = maxValue;

    if(_maxValue != null) {
      _minutes = (_maxValue/2).round();
    }
    else {
      _minutes = 1;
    }
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
          onPressed: () => Navigator.of(context).pop(),
        ),
        // Wrapper-Klasse für den Picker mit Titel
        /* Minutes_Picker( 
          title: "Geschätzte Redezeit...",
          initialeValue: _minutes,
          minValue: 1,
          maxValue: 10,
        )*/
      ],
    );
  }
}