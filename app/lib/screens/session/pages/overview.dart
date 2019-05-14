import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:app/screens/session/session_arguments.dart';
import 'package:app/screens/add_contribution/index.dart';
import 'package:app/models/debate.dart';
import 'package:app/util/colors.dart';

class OverviewScreen extends StatefulWidget {
  final Debate _debate;
  final Author author;

  OverviewScreen(this._debate, {Key key, this.author}) : super(key: key);

  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {

  Timer _timer;
  DateTime _startTime;
  DateTime _currentTime;
  Duration _previous = Duration();

  void _onPressStart() {
    _startTime = DateTime.now();

    const duration = const Duration(milliseconds: 10);
    _timer = Timer.periodic(duration, (Timer timer) {
      setState(() => _currentTime = DateTime.now());
    });
  }

  void _onPressStop() {
    _timer.cancel();
    _previous = _previous + Duration(milliseconds: _currentTime.millisecondsSinceEpoch - _startTime.millisecondsSinceEpoch);
  }

  void _onPressArchive() {

  }

  void _onPressAdd(BuildContext context) {
    SessionArguments arguments = SessionArguments(widget._debate, widget.author);
    Navigator.pushNamed(context, AddContribution.routeName, arguments: arguments);
  }

  void _onTapListItem(Contribution contribution) {
    //if (widget.author != null) return; // Not an owner

    showBottomSheet(context: context, builder: (BuildContext context) {
      var timerText = '00:00.00';

      if (_startTime != null) {
        var difference = _currentTime.millisecondsSinceEpoch - _startTime.millisecondsSinceEpoch;
        var duration = Duration(milliseconds: difference) + _previous;
        var milliseconds = duration.inMilliseconds % 1000;
        var seconds = duration.inSeconds % 60;
        var minutes = duration.inMinutes;
        timerText = '${minutes < 10 ? 0 : ''}$minutes:${seconds < 10 ? 0 : ''}$seconds.${milliseconds.toString().substring(0, 2)}';
      }

      var firstButtonText = 'Starten';
      var firstButtonColor = Colors.deepPurple;
      var firstButtonHandler = _onPressStart;

      if (_timer != null && _timer.isActive) {
        firstButtonText = 'Stoppen';
        firstButtonColor = Colors.red;
        firstButtonHandler = _onPressStop;
      } else if (_startTime != null) {
        firstButtonText = 'Fortsetzen';
        firstButtonColor = Theme.of(context).primaryColor;
        firstButtonHandler = _onPressStart;
      }

      return Container(
        color: Colors.black87,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 4.0, bottom: 12.0),
                        child: Text('${contribution.author.name} - ${contribution.content}',
                          style: DefaultTextStyle.of(context).style.apply(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 16.0),
                            child: RaisedButton(
                              color: firstButtonColor,
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                              child: Text(firstButtonText),
                              onPressed: firstButtonHandler,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text(timerText,
                              style: DefaultTextStyle.of(context).style.apply(
                                fontSizeFactor: 2,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 16.0),
                            child: RaisedButton(
                              disabledColor: Colors.transparent,
                              disabledTextColor: Colors.transparent,
                              textColor: Colors.white,
                              color: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                              child: Text('Archivieren'),
                              onPressed: _startTime == null ? null : _onPressArchive,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )
            ),
          ],
        ),
      );
    });
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    if (document.documentID == 'metadata') return null;

    var contribution = Contribution.fromJson(document.data);

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
      /*floatingActionButton: widget.author != null ? FloatingActionButton(
        onPressed: () => _onPressAdd(context),
        child: Icon(Icons.add),
      ) : null,*/
    );
  }
}
