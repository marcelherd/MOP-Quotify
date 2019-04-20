import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class MessageAdd extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _MessageAdd();
  }
}

class _MessageAdd extends State<MessageAdd> {
  
  int _minutes = 1;
  String _messageTitle;
  TextField _textField;
  SimpleDialog _dialog;
  NumberPicker _minutePicker;

  _MessageAdd() {

    _textField = new TextField(
      decoration: InputDecoration(
      border: OutlineInputBorder(),
      hintText: 'Meldetitel',
      ),
      onChanged: (messageTitle) => 
        setState(() => _messageTitle = messageTitle),
    );

    _minutePicker = NumberPicker.integer(
      initialValue: _minutes,
      minValue: 1,
      maxValue: 10,
      onChanged: (currentNumber) => 
        setState(() => _minutes = currentNumber),
    );

    _dialog = SimpleDialog(
      title: Text('Wortmeldung hinzufügen...'),
      contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 12),
      children: <Widget>[
        _textField,
        _minutePicker,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _dialog;
  }
}