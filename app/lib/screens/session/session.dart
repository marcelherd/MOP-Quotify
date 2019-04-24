import 'package:flutter/material.dart';

import 'session_arguments.dart';

import 'pages/overview.dart';
import 'pages/statistics.dart';

// TODO(marcelherd): This should be stateful, showDialog in initState depending on reason
class Session extends StatelessWidget {
  static const routeName = '/Session';

  @override
  Widget build(BuildContext context) {
    final SessionArguments args = ModalRoute.of(context).settings.arguments;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: <Widget>[
                Expanded(
                  child: Text(args?.debate?.topic),
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
              OverviewScreen(args?.debate, args?.reason),
              StatisticsScreen(),
            ],
          )),
    );
  }
}
