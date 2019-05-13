import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:app/models/debate.dart';

class SpeakersScreen extends StatelessWidget {
  final Debate _debate;
  final Author _author;

  SpeakersScreen(this._debate, [this._author]);

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    if (document.documentID == 'metadata') return null;

    var author = Author.fromJson(document.data);

    var chips = <Widget>[];
    author.customProperties.forEach((k, v) {
      var text = (v is String) ? Text(v) : Text(k);
      var chip = Padding(
        padding: EdgeInsets.only(right: 8.0),
        child: Chip(label: text),
      );

      chips.add(chip);
    });

    return ListTileTheme(
      child: ListTile(
        isThreeLine: true,
        selected: _author.name == author.name,
        title: Text(author.name),
        subtitle: Row(children: chips),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: StreamBuilder(
          stream: Firestore.instance.collection(_debate.debateCode + '_authors').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text('Loading...');

            return ListView.builder(
              itemExtent: 80.0,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) => _buildListItem(context, snapshot.data.documents[index]),
            );
          },
        ),
      ),
    );
  }
}
