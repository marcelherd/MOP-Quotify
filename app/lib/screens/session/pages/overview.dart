import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:app/screens/session/index.dart';
import 'package:app/models/debate.dart';

class OverviewScreen extends StatelessWidget {
  final Debate _debate;
  final Author _author;

  OverviewScreen(this._debate, [this._author]);

  void _onPressAdd() {
    /*Firestore.instance.collection(_debateCode).document().setData({
      'text': 'Sample 4',
      'clicks': 0
    });*/
  }

  void _onTapListItem(DocumentSnapshot document) {
    /*Firestore.instance.runTransaction((transaction) async {
      DocumentSnapshot freshSnapshot =
          await transaction.get(document.reference);
      await transaction.update(freshSnapshot.reference, {
        'clicks': freshSnapshot['clicks'] + 1,
      });
    });*/
    if (_author != null) return; // Not an owner
  }

  /*Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    if (document.documentID == 'metadata') return null;

    return ListTile(
      title: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              document['text'].toString(),
              style: Theme.of(context).textTheme.headline,
            ),
          ),
          Text(
            document['clicks'].toString(),
            style: Theme.of(context).textTheme.headline,
          ),
        ],
      ),
      onTap: () => _onTapListItem(document),
    );
  }*/

  /*Widget _buildListItem(BuildContext context, Contribution contribution) {
    return ListTile(
      isThreeLine: true,
      title: Row(
        children: <Widget>[
          Expanded(child: Text(contribution.content)),
          Text('(${contribution.duration}ms)')
        ],
      ),
      subtitle: Text(contribution.author.name),
      onTap: () {},
    );
  }*/

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    if (document.documentID == 'metadata') return null;

    var contribution = Contribution.fromJson(document.data);

    var chips = <Widget>[
      Expanded(child: Text(contribution.author.name)),
    ];

    contribution.author.customProperties.forEach((k, v) {
      var text = (v is String) ? Text(v) : Text(k);
      var chip = Padding(
        padding: EdgeInsets.only(left: 8.0),
        child: Chip(label: text),
      );

      chips.add(chip);
    });

    var duration = (contribution.duration / 60).round();

    return ListTileTheme(
      textColor: contribution.archived ? Colors.grey : ListTileTheme.of(context).textColor,
      child: ListTile(
        isThreeLine: true,
        selected: contribution.speaking,
        title: Row(
          children: <Widget>[
            Expanded(child: Text(contribution.content)),
            Text('$duration min',
              style: Theme.of(context).textTheme.subtitle,
            ),
          ],
        ),
        subtitle: Row(children: chips),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        /*child: StreamBuilder(
              stream: Firestore.instance.collection(_debateCode).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Text('Loading...');

                return ListView.builder(
                  itemExtent: 80.0,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) =>
                      _buildListItem(context, snapshot.data.documents[index]),
                );
              })),*/
        /*child: ListView.builder(
          itemExtent: 80.0,
          itemCount: _debate.contributions.length,
          itemBuilder: (context, index) =>
              _buildListItem(context, _debate.contributions[index]),
        ),*/
        child: StreamBuilder(
          stream: Firestore.instance.collection(_debate.debateCode).snapshots(),
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
      floatingActionButton: FloatingActionButton(
        onPressed: _onPressAdd,
        child: Icon(Icons.add),
      ),
    );
  }
}
