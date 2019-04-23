import 'package:flutter/material.dart';

import 'package:app/models/debate.dart';

import 'pages/overview.dart';
import 'pages/statistics.dart';

// TODO(marcelherd): This should be stateful (?)
class Session extends StatelessWidget {
  static const routeName = '/Session';

  @override
  Widget build(BuildContext context) {
    final Debate debate = ModalRoute.of(context).settings.arguments;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: <Widget>[
                Expanded(
                  child: Text(debate?.topic),
                ),
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {},
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
              OverviewScreen(debate),
              StatisticsScreen(),
            ],
          )),
    );
  }
}
