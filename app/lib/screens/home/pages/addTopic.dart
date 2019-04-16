import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Topic {
  List<String> choices = new List<String>();
  String title = "";

  Topic(String title, List<String> choices){
    this.choices = choices;
    this.title = title;
  }
}

class AddTopic extends StatefulWidget {

  @override
  _AddTopicState createState() => _AddTopicState();

}

class _AddTopicState extends State<AddTopic>  {
  final _categoryNameController = TextEditingController();
  final _nextTopicController = TextEditingController();
  static const routeName = '/Create/AddTopic';
  List<Widget> choices = List<Widget>();

  void _onPressAdd(BuildContext context){
    Topic retval = Topic(_categoryNameController.text, []);
    Navigator.pop(context, retval);
  }

  void _onPressAddTopic(){
    List<Widget> children = List<Widget>();
    Widget curRow = Row(
      children: children,
      );
      children.add(Text(_nextTopicController.text));
      children.add(IconButton(
          icon: Icon(Icons.remove),
          onPressed: () => { setState(() {choices.remove(curRow);})},
        ));

      setState( () {
        choices.add(curRow);
        _nextTopicController.text = "";
      });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Neue Kategorie")
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
          child: Column(
            children: <Widget>[
              TextField(
                  controller: _categoryNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Kategorie',
                  ),
                ),
                SizedBox(height: 16),
              Column(children: <Widget>[   
                TextField(
                  controller: _nextTopicController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Topic',
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _onPressAddTopic
                ),
              ],),
              Column(children: choices),
            ],
          )
      ),
      persistentFooterButtons: <Widget>[
        FlatButton(
          child: Text('Hinzufügen'),
          onPressed: () => _onPressAdd(context),
        )
      ],
    );
  }
}

