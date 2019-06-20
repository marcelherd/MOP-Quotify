import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:app/screens/session/session_arguments.dart';
import 'package:app/screens/add_contribution/index.dart';
import 'package:app/screens/session/widgets/timer_bottom_sheet.dart';
import 'package:app/services/debate_service.dart';
import 'package:app/models/debate.dart';
import 'package:app/util/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OverviewScreen extends StatefulWidget {
  final Debate _debate;
  final Author author;

  OverviewScreen(this._debate, {Key key, this.author}) : super(key: key);

  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {

  var _presentContribution = false;
  var inactiveContributions = 0;
  var allContributions = 0;

  void _onPressAdd(BuildContext context) {
    if(!_presentContribution){
      SessionArguments arguments = SessionArguments(widget._debate, widget.author);
      Navigator.pushNamed(context, AddContribution.routeName, arguments: arguments);
      
    }else{
      Fluttertoast.showToast(
          msg: "Es kann nur eine Wortmeldung zur gleichen Zeit existieren. Lösche deine vorherige, bevor du eine neue abgibst.",
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIos: 8);
      }
    
  }

  void _onTapListItem(Contribution contribution) {
    if (widget.author != null) return; // Not an owner
    if (contribution.archived) return;

    showModalBottomSheet(context: context, builder: (BuildContext context) => TimerBottomSheet(contribution, widget._debate.debateCode));
  }



  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    if (document.documentID == 'metadata') {
      if (document.data['_closed']) {
        Navigator.popUntil(context, ModalRoute.withName('/'));
      }
      return null;
    }

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
    if(contribution.author.name == widget.author.name){
      allContributions++;
      if(contribution.archived || contribution.speaking){
        inactiveContributions++;
      }
    }
    if (contribution.archived) {
      durationStyle = durationStyle.apply(color: Colors.grey);
    }
    if (contribution.speaking) {
      durationStyle = durationStyle.apply(color: Colors.transparent);
    }
    IconButton deleteButton = contribution.author.name == widget.author.name && !contribution.archived && !contribution.speaking ?
     IconButton(icon: Icon(Icons.delete),onPressed:  () {
       DebateService.deleteContribution(widget._debate.debateCode, document.documentID);
     },): null;
    final listTile = ListTileTheme(
      textColor: contribution.archived ? Colors.grey : ListTileTheme.of(context).textColor,
      child: ListTile(
        isThreeLine: true,
        selected: contribution.speaking,
        onTap: widget.author != null ? null : () => _onTapListItem(contribution),
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
    if(deleteButton != null){
      ((listTile.child as ListTile).title as Row).children.insert(1, deleteButton);
    }
    _presentContribution = allContributions != inactiveContributions;
    // Non-owners can't dismiss
    if (widget.author != null) {
      return listTile;
    }

    return Dismissible(
      key: Key(document.documentID),
      direction: DismissDirection.startToEnd,
      background: Material(
        color: Theme.of(context).errorColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: IconTheme(
                data: IconThemeData(color: Colors.white),
                child: Icon(Icons.delete),
              )
            )
          ],
        )
      ),
      onDismissed: (direction) => DebateService.deleteContribution(widget._debate.debateCode, document.documentID),
      child: listTile,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: StreamBuilder(
          stream: Firestore.instance
            .collection(widget._debate.debateCode)
            .orderBy('archived')
            .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text('Loading...');
            
            allContributions = 0;
            inactiveContributions = 0;
            var listView = ListView.builder(
              itemExtent: 80.0,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) => _buildListItem(context, snapshot.data.documents[index]),
            );
            return listView;
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
