import 'package:flutter/material.dart';

import 'debate_arguments.dart';
import 'pages/overview.dart';
import 'pages/statistics.dart';

class Debate extends StatelessWidget {

  static const routeName = '/Debate';

  @override
  Widget build(BuildContext context) {
    final DebateArguments args = ModalRoute.of(context).settings.arguments;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text(args.topic),
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
