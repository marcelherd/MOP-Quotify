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

    if (args.author != null) {
      debugPrint('Ich bin der Debatte beigetreten: ${args.author.name}');
    } else {
      debugPrint('Ich bin Ersteller der Debatte');
    }

    var tabs = <Widget>[
      Tab(text: 'Übersicht'),
      Tab(text: 'Statistik'),
    ];

    if (args.author != null) {
      tabs.addAll(<Widget>[
        Tab(text: 'Redner'),
      ]);
    }

    return DefaultTabController(
      length: 3,
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
            children: <Widget>[
              OverviewScreen(args?.debate, args?.author),
              StatisticsScreen(),
              SpeakersScreen(args?.debate, args?.author),
            ],
          )),
    );
  }
}
