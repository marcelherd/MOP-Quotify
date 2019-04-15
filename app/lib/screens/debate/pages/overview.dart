import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OverviewScreen extends StatelessWidget {
  void _onPressAdd() {
    Firestore.instance.collection('samples').document().setData({
      'text': 'Sample 4',
      'clicks': 0
    });
  }

  void _onTapListItem(DocumentSnapshot document) {
    Firestore.instance.runTransaction((transaction) async {
      DocumentSnapshot freshSnapshot =
          await transaction.get(document.reference);
      await transaction.update(freshSnapshot.reference, {
        'clicks': freshSnapshot['clicks'] + 1,
      });
    });
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(16),
          child: StreamBuilder(
              stream: Firestore.instance.collection('samples').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Text('Loading...');

                return ListView.builder(
                  itemExtent: 80.0,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) =>
                      _buildListItem(context, snapshot.data.documents[index]),
                );
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: _onPressAdd,
        child: Icon(Icons.add),
      ),
    );
  }
}
