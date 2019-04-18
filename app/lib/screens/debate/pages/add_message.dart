import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

class MessageAdd extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _MessageAdd();
  }
}

class _MessageAdd extends State<MessageAdd> {
  int minutes;
  String messageTitle;

  _onShowPicker(BuildContext context){
        new Picker(
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
          print(value.toString());
          print(picker.getSelectedValues());
        }
    ).showDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Meldetitel',
          ),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _onShowPicker(context),
        )  
      ],
    );
  }
}