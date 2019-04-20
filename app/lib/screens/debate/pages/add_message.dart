import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

class MessageAdd extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _MessageAdd();
  }
}

class _MessageAdd extends State<MessageAdd> {
  
  int _minutes;
  String _messageTitle;
  TextField _textField;
  Picker _picker;
  SimpleDialog _dialog;
  ScaffoldState _result;

  _MessageAdd() {

    _textField = new TextField(
      decoration: InputDecoration(
      border: OutlineInputBorder(),
      hintText: 'Meldetitel',
      ),
      onChanged: (messageTitle) => _messageTitle = messageTitle,
    );

    _dialog = SimpleDialog(
      title: Text('Wortmeldung hinzufügen...'),
      contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 12),
      children: <Widget>[
        _textField,
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => {
            _result = context.ancestorStateOfType(const TypeMatcher<ScaffoldState>()),
          _onShowPicker(context)
          },
        )
      ],
    );

    _picker = new Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(begin: 0, end: 999),
        ]),
        delimiter: [
          PickerDelimiter(child: Container(
            width: 30.0,
            alignment: Alignment.center,
            child: Icon(Icons.more_vert),
          ))
        ],
        hideHeader: true,
        title: new Text("Ungefähr geschätzte Redezeit..."),
        onConfirm: (Picker picker, List value) {
          _minutes = _getPickerValue();        }
    );
  }

  _onShowPicker(BuildContext context){ 
    return _picker.showDialog(context);
  }

  int _getPickerValue() {
    return _picker.getSelectedValues().first;
  }

  @override
  Widget build(BuildContext context) {
    return _dialog;
  }
}