import 'package:flutter/material.dart';

import 'session_arguments.dart';

import 'pages/overview.dart';
import 'pages/statistics.dart';
import 'pages/speakers.dart';

class Session extends StatefulWidget {
  static const routeName = '/Session';

  Session({Key key}) : super(key: key);

  _SessionState createState() => _SessionState();
}

class _SessionState extends State<Session> {
  @override
  Widget build(BuildContext context) {
    final SessionArguments args = ModalRoute.of(context).settings.arguments;
    
    var tabLength = 2;
    var tabs = <Widget>[
      Tab(text: 'Übersicht'),
      Tab(text: 'Statistik'),
    ];

    var views = <Widget>[
      OverviewScreen(args?.debate, args?.author),
      StatisticsScreen(),
    ];

    if (args.author == null) {
      tabs.add(Tab(text: 'Teilnehmer'));
      views.add(SpeakersScreen(args?.debate, args?.author));
      tabLength++;
    }

    return DefaultTabController(
      length: tabLength,
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
              tabs: tabs,
            ),
          ),
          body: TabBarView(
            children: views,
          )),
    );
  }
}
