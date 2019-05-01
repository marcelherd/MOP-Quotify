import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:app/screens/debate/index.dart';
import 'addTopic.dart';

class CreateScreen extends StatefulWidget {

  @override
  _CreateState createState() => _CreateState();

}

class _CreateState extends State<CreateScreen> {

  final _inputController = TextEditingController();
  List<Widget> topicBoxes = List<Widget>();
  List<Topic> topics = List<Topic>();

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _onPressCreate() {
    if (_inputController.text.isEmpty) return; // No topic set

    final debateCode = _inputController.text; // TODO(marcelherd): Actually generate a code. Should not be longer than 8 chars

    // TODO(marcelherd): avoid nesting
    Firestore.instance.collection(debateCode).getDocuments().then((QuerySnapshot snapshot) {
      if (snapshot.documents.isNotEmpty) return; // debateCode collision, should not happen

      // Create new collection for this debate
      Firestore.instance
        .collection(debateCode) 
        .document('metadata')
        .setData({
          '_topic': _inputController.text,
          'gender': ['Male', 'Female', 'Other'], // TODO(marcelherd): No need to save gender, duration, contribution once we create a model class
          'duration': 'number',
          'contribution': 'string',
          // TODO(marcelherd): (only) set custom columns here
      });

      Navigator.pushNamed(context, Debate.routeName, arguments: DebateArguments(debateCode: debateCode));
    });
  }



  void _onPressedAddTopic({Topic lookedTopic}) async {
    Topic result = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddTopic(topic: lookedTopic)));
    if(result != null){
      bool topicAlreadyExists = false;
      for(int i = 0; i<topics.length; i++){
        if(topics[i].title == result.title){
          topics[i] = result;
          topicAlreadyExists = true;
          break;
        }
      }
      if(!topicAlreadyExists){
        topics.add(result);
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
        child: Column(
          children: <Widget>[
            Text(
              'Debatte erstellen',
              style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _inputController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Thema',
              ),
            ),
            Column(
              children: topics.map<Widget>((Topic topic) {
                return FlatButton(
                          child: Text(topic.title),
                          onPressed: () => _onPressedAddTopic(lookedTopic: topic),
                        );
              }).toList(),
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: _onPressedAddTopic,
            )
          ],
        ),
      ),
      persistentFooterButtons: <Widget>[
        FlatButton(
          child: Text('Erstellen'),
          onPressed: _onPressCreate,
        )
      ],
    );
  }
}
