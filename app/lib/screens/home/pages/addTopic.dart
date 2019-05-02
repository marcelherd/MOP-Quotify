import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Topic {
  List<String> choices = <String>[];
  String title = "";
  TopicDropdownOption choosedOption;

  Topic(String title, List<String> choices, TopicDropdownOption choosedOption){
    this.choices = choices;
    this.title = title;
    this.choosedOption = choosedOption;
  }

    static Map<TopicDropdownOption, String> topicToString = {
    TopicDropdownOption.YesNo: "Ja / Nein",
    TopicDropdownOption.Text: "Text",
    TopicDropdownOption.SingleChoice: "Einzelauswahl",
    TopicDropdownOption.MultipleChoice: "Mehrfachauswahl"
  };
}

enum TopicDropdownOption {
  YesNo,
  Text,
  SingleChoice,
  MultipleChoice
}

class AddTopic extends StatefulWidget {
  Topic topic;
  AddTopic({Topic topic}){
    this.topic = topic;
  }

  @override
  _AddTopicState createState() => _AddTopicState(topic: topic);

}

class _AddTopicState extends State<AddTopic>  {
  static const routeName = '/Create/AddTopic';
  final _categoryNameController = TextEditingController();
  final _nextTopicController = TextEditingController();

  TopicDropdownOption dropdownValue = TopicDropdownOption.YesNo;

  
  List<String> choices = <String>[];
  double multipleOpacity = 0;

  _AddTopicState({Topic topic}){
    if(topic != null){
        choices = topic.choices;
        dropdownValue = topic.choosedOption;
        _categoryNameController.text = topic.title;
        _onDropdownChanged(dropdownValue);
    }
  }

  void _onPressAdd(BuildContext context){
    Topic retval = Topic(_categoryNameController.text, choices, dropdownValue);
    if(retval.title == ""){
      Fluttertoast.showToast(
        msg: "Es muss ein Titel für die Kategorie angegeben werden!",
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 2
      );
    }else if(retval.choices.length <= 2 && dropdownValue == TopicDropdownOption.MultipleChoice){
      Fluttertoast.showToast(
        msg: "In einer Mehrfachauswahl müssen mindestens 2 Auswahlmöglichkeiten angegeben werden!",
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 2
      );
    }else{
      Navigator.pop(context, retval);
    }
  }

  void _onPressAddTopic(BuildContext context){
    String choice = _nextTopicController.text;
    if(choice == ""){
      Fluttertoast.showToast(
        msg: "Topic darf nicht leer sein!",
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 2
      );
      FocusScope.of(context).detach();
      return;
    }
    if(!choices.contains(choice)){
      setState( () {
        choices.add(_nextTopicController.text);
        _nextTopicController.text = "";
      });
    }else{
      Fluttertoast.showToast(
        msg: "$choice ist bereits als Auswahl vorhanden!",
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 2
      );
    }

  }

  void _onDropdownChanged(TopicDropdownOption newValue){
    dropdownValue = newValue;
    if(newValue == TopicDropdownOption.MultipleChoice){
    multipleOpacity = 1;
    }else{
      multipleOpacity = 0;
    }
  }

  void _onTopicDismissed(int index){
    setState(() => {
      choices.removeAt(choices.length - index - 1)
    });
  }

  void _onTopicEditComplete(int index, TextEditingController controller){
    setState(() => {
      choices[index] = controller.text
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
              Row(
                children: <Widget>[
                  Flexible(
                    child:
                    TextField(
                      controller: _categoryNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Kategorie',
                      ),
                    ),
                  ),
                  SizedBox(width:16),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child:
                    DropdownButton<TopicDropdownOption>(
                    value: dropdownValue,
                    onChanged: (TopicDropdownOption newValue) {
                      setState(() {
                        _onDropdownChanged(newValue);
                      });
                    },
                    items: Topic.topicToString.keys.map<DropdownMenuItem<TopicDropdownOption>>((TopicDropdownOption value) {
                      return DropdownMenuItem<TopicDropdownOption>(
                        value: value,
                        child: Text(Topic.topicToString[value]),
                      );
                    }).toList(),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, style: BorderStyle.solid, width: 0.80)
                  ),
                  ),
                ],
              ),
              SizedBox(height:32),
              Expanded(
                child: Opacity(opacity:multipleOpacity,
                  child: Column(
                    children: <Widget>[
                        Row(
                          children: <Widget>[
                            Flexible(
                              child:
                                TextField(
                                    controller: _nextTopicController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Topic',
                                    ),
                                    onEditingComplete: () => _onPressAddTopic(context),
                                  ),
                            ),
                            IconButton(
                              icon: Icon(Icons.check),
                              onPressed: FocusScope.of(context).detach,
                            )
                          ],
                        ),
                        Flexible(
                          child: 
                          ListView.builder(
                            itemCount: choices.length,
                            itemBuilder: (context, index) {
                              String choice = choices[choices.length - index - 1];
                              TextEditingController controller = TextEditingController();
                              controller.text = choice;
                              return Dismissible(
                                key: Key(choice),
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(96, 16, 96, 16),
                                  child: TextField(
                                    controller: controller,
                                    decoration: InputDecoration(
                                      hintText: 'Topic'
                                    ),
                                    onEditingComplete: () => _onTopicEditComplete(index, controller),
                                  ),
                                ),
                                onDismissed: (direction) => _onTopicDismissed(index),
                              );
                            },
                          )
                      )
                    ],
                  )
                )
              )
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

