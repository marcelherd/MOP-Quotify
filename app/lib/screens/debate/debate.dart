import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'widgets/share_bottom_sheet.dart';

import 'debate_arguments.dart';
import 'pages/overview.dart';
import 'pages/statistics.dart';

// TODO(marcelherd): This should be stateful (?)
class Debate extends StatelessWidget {
  static const routeName = '/Debate';

  // TODO(marcelherd): This should be a class
  String _debateCode = 'Loading...';
  String _topic = 'Loading...';

  Future<void> _onPressShare(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ShareBottomSheet(_debateCode, bottomSheetContext: context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final DebateArguments args = ModalRoute.of(context).settings.arguments;

    Firestore.instance
      .collection(args.debateCode)
      .document('metadata')
      .get()
      .then((DocumentSnapshot snapshot) {
        _debateCode = args.debateCode;
        _topic = snapshot.data['_topic'];
      });

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: <Widget>[
                Expanded(child: Text(_topic)), // TODO(marcelherd): Use FutureBuilder (?)
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () => _onPressShare(context),
                ),
              ],
            ),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(text: 'Übersicht'),
                Tab(text: 'Statistik'),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              OverviewScreen(),
              StatisticsScreen(),
            ],
          )),
    );
  }
}
