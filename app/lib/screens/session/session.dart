import 'package:flutter/material.dart';

import 'session_arguments.dart';

import 'pages/overview.dart';
import 'pages/statistics.dart';

class Session extends StatefulWidget {
  static const routeName = '/Session';

  Session({Key key}) : super(key: key);

  _SessionState createState() => _SessionState();
}

class _SessionState extends State<Session> {
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
