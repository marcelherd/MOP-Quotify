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

  Widget _buildListItem(BuildContext context, Contribution contribution) {
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
        child: ListView.builder(
          itemExtent: 80.0,
          itemCount: _debate.contributions.length,
          itemBuilder: (context, index) =>
              _buildListItem(context, _debate.contributions[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onPressAdd,
        child: Icon(Icons.add),
      ),
    );
  }
}