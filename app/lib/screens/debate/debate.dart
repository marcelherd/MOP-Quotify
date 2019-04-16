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
  Future<DocumentSnapshot> _debateData;

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
    _debateCode = args.debateCode;
    _debateData = Firestore.instance
        .collection(args.debateCode)
        .document('metadata')
        .get();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: <Widget>[
                Expanded(
                  child: FutureBuilder<DocumentSnapshot>(
                    future: _debateData,
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Text('NONE');
                        case ConnectionState.active:
                        case ConnectionState.waiting:
                          return Text('Loading...');
                        case ConnectionState.done:
                          if (snapshot.hasError)
                            return Text('Error: ${snapshot.error}');
                          return Text(snapshot.data.data['_topic']);
                      }
                      return null;
                    },
                  ),
                ),
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
              OverviewScreen(args.debateCode),
              StatisticsScreen(),
            ],
          )),
    );
  }
}
