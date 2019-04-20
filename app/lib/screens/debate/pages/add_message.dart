import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'minute_Picker.dart';

class MessageAdd extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _MessageAdd();
  }
}

class _MessageAdd extends State<MessageAdd> {
  
  int _minValue = 1;
  int _maxValue = 10;
  int _minutes;
  String _messageTitle;

  _MessageAdd({
    @required int minValue, 
    @required int maxValue}) {
    _minValue = minValue;
    _maxValue = maxValue;
    _minutes = (_maxValue/2).round();
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
        SimpleDialogOption(
          onPressed: () => Navigator.pop(context),
        )
        /* IconButton(
          icon: Icon(Icons.check)
        ),*/
        /* Minute_Picker( 
          title: "Geschätzte Redezeit...",
          initialeValue: _minutes,
          minValue: 1,
          maxValue: 10,
        )*/
      ],
    );
  }
}