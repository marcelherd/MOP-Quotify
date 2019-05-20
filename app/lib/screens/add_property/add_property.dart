import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:app/models/property.dart';

class AddProperty extends StatefulWidget {
  static const routeName = '/Create/AddTopic';

  @override
  _AddPropertyState createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
  final _categoryNameController = TextEditingController();
  final _nextTopicController = TextEditingController();

  PropertyType _dropdownValue = PropertyType.YesNo;

  var _choices = <String>[];
  double _multipleOpacity = 0;

  @override
  void dispose() {
    _categoryNameController.dispose();
    _nextTopicController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final Property property = ModalRoute.of(context).settings.arguments;
      if (property != null) {
        _choices = property.choices;
        _dropdownValue = property.propertyType;
        _categoryNameController.text = property.title;
        setState(() => _onDropdownChanged(_dropdownValue));
      }
    });
  }

  void _onPressAdd(BuildContext context) {
    Property retval =
        Property(_categoryNameController.text, _dropdownValue, _choices);
    if (retval.title == "") {
      Fluttertoast.showToast(
          msg: "Es muss ein Titel für die Kategorie angegeben werden!",
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 2);
    } else if (retval.choices.length < 2 &&
        _dropdownValue == PropertyType.SingleChoice) {
      Fluttertoast.showToast(
          msg:
              "In einer Einzelauswahl müssen mindestens 2 Auswahlmöglichkeiten angegeben werden!",
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 2);
    } else {
      Navigator.pop(context, retval);
    }
  }

  void _onPressAddTopic(BuildContext context) {
    String choice = _nextTopicController.text;
    if (choice == "") {
      Fluttertoast.showToast(
          msg: "Topic darf nicht leer sein!",
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 2);
      return;
    }
    if (!_choices.contains(choice)) {
      setState(() {
        _choices.add(_nextTopicController.text);
        _nextTopicController.text = "";
      });
    } else {
      Fluttertoast.showToast(
          msg: "$choice ist bereits als Auswahl vorhanden!",
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 2);
    }
    FocusScope.of(context).detach();
  }

  void _onDropdownChanged(PropertyType newValue) {
    _dropdownValue = newValue;
    if (newValue == PropertyType.SingleChoice) {
      _multipleOpacity = 1;
    } else {
      _multipleOpacity = 0;
    }
  }

  void _onTopicDismissed(int index) {
    setState(() => {_choices.removeAt(_choices.length - index - 1)});
  }

  void _onTopicEditComplete(int index, TextEditingController controller) {
    
    FocusScope.of(context).detach();
    debugPrint(_choices[index]);
    setState(() => {_choices[index] = controller.text});
  }

  Widget _buildMultipleSelection(BuildContext context) {
    if (_dropdownValue != PropertyType.SingleChoice) return null;
    return Text('Multiauswahl');
  }

  @override
  Widget build(BuildContext context) {
    final Property property = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text(property == null ? 'Neues Merkmal' : 'Merkmal ${property.title}')),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      controller: _categoryNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Bezeichnung',
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: DropdownButton<PropertyType>(
                      value: _dropdownValue,
                      onChanged: (PropertyType newValue) {
                        setState(() {
                          _onDropdownChanged(newValue);
                        });
                      },
                      items: Property.propertyToString.keys
                          .map<DropdownMenuItem<PropertyType>>(
                              (PropertyType value) {
                        return DropdownMenuItem<PropertyType>(
                          value: value,
                          child: Text(Property.propertyToString[value]),
                        );
                      }).toList(),
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 0.80)),
                  ),
                ],
              ),
              SizedBox(height: 32),
              Expanded(
                  child: Opacity(
                      opacity: _multipleOpacity,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Flexible(
                                child: TextField(
                                  controller: _nextTopicController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Topic',
                                  ),
                                  onEditingComplete: () =>
                                      _onPressAddTopic(context),
                                ),
                              ),
                            ],
                          ),
                          Flexible(
                              child: ListView.builder(
                            itemCount: _choices.length,
                            itemBuilder: (context, index) {
                              String choice =
                                  _choices[_choices.length - index - 1];
                              TextEditingController controller =
                                  TextEditingController();
                              controller.text = choice;
                              return Dismissible(
                                key: Key(choice),
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(96, 16, 96, 16),
                                  child: TextField(
                                    controller: controller,
                                    decoration:
                                        InputDecoration(hintText: 'Topic'),
                                    onEditingComplete: () =>
                                        _onTopicEditComplete(_choices.length - index - 1, controller),
                                  ),
                                ),
                                onDismissed: (direction) =>
                                    _onTopicDismissed(index),
                              );
                            },
                          ))
                        ],
                      )))
            ],
          )),
      persistentFooterButtons: <Widget>[
        FlatButton(
          child: Text('Speichern'),
          onPressed: () => _onPressAdd(context),
        )
      ],
    );
  }
}
