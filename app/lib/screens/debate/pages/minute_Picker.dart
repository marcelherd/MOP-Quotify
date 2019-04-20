import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class Minute_Picker extends StatefulWidget{

  String _title;
  int _initialeValue;
  int _minValue;
  int _maxValue;  

  Minute_Picker({
    String title,
    @required int initialeValue, 
    int minValue, 
    int maxValue}) {
    _title = title;
    _initialeValue = initialeValue;
    _minValue = minValue;
    _maxValue = maxValue;
  }
  
  @override
  State<StatefulWidget> createState() {
    return _Minute_Picker(
      title: _title, 
      initialeValue: _initialeValue,
      minValue: _minValue,
      maxValue: _maxValue);
  }
}

class _Minute_Picker extends State<Minute_Picker> {

  String _title;
  int _initialeValue;
  int _minValue;
  int _maxValue;

  _Minute_Picker({String title, int initialeValue, int minValue, int maxValue}) {
    _title = title;
    _initialeValue = initialeValue;
    _minValue = minValue;
    _maxValue = maxValue;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Text(_title ?? ""),
            NumberPicker.integer(
              initialValue: _initialeValue,
              minValue: _minValue ?? 0,
              maxValue: _maxValue ?? 999,
            )
          ],
        ),
      ),
    );
  }
}