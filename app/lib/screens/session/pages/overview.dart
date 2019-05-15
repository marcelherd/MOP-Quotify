import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:app/screens/session/session_arguments.dart';
import 'package:app/screens/add_contribution/index.dart';
import 'package:app/screens/session/widgets/timer_bottom_sheet.dart';
import 'package:app/models/debate.dart';
import 'package:app/util/colors.dart';

class OverviewScreen extends StatefulWidget {
  final Debate _debate;
  final Author author;

  OverviewScreen(this._debate, {Key key, this.author}) : super(key: key);

  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {

  void _onPressAdd(BuildContext context) {
    SessionArguments arguments = SessionArguments(widget._debate, widget.author);
    Navigator.pushNamed(context, AddContribution.routeName, arguments: arguments);
  }

  void _onTapListItem(Contribution contribution) {
    if (widget.author != null) return; // Not an owner
    if (contribution.archived) return;

    showModalBottomSheet(context: context, builder: (BuildContext context) => TimerBottomSheet(contribution, widget._debate.debateCode));
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    if (document.documentID == 'metadata') return null;

    var contribution = Contribution.fromJson(document.data, document.documentID);

    var chips = <Widget>[
      Expanded(child: Text(contribution.author.name)),
      Chip(
        label: Text(getGenderText(contribution.author.gender)[0]),
        backgroundColor: getGenderColor(contribution.author.gender),
      ),
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

    var durationStyle = Theme.of(context).textTheme.subtitle;
    if (contribution.archived) {
      durationStyle = durationStyle.apply(color: Colors.grey);
    }
    if (contribution.speaking) {
      durationStyle = durationStyle.apply(color: Colors.transparent);
    }

    return ListTileTheme(
      textColor: contribution.archived ? Colors.grey : ListTileTheme.of(context).textColor,
      child: ListTile(
        isThreeLine: true,
        selected: contribution.speaking,
        onTap: () => _onTapListItem(contribution),
        title: Row(
          children: <Widget>[
            Expanded(child: Text(contribution.content)),
            Text('$duration min',
              style: durationStyle,
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
        child: StreamBuilder(
          stream: Firestore.instance.collection(widget._debate.debateCode).snapshots(),
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
      floatingActionButton: widget.author != null ? FloatingActionButton(
        onPressed: () => _onPressAdd(context),
        child: Icon(Icons.add),
      ) : null,
    );
  }
}
