import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'session_arguments.dart';

import 'pages/overview.dart';
import 'pages/statistics.dart';
import 'pages/speakers.dart';
import 'package:share/share.dart';

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
      OverviewScreen(args?.debate, author: args?.author),
      StatisticsScreen(args?.debate, author: args?.author),
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
                  icon: Icon(Icons.content_copy),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: args?.debate?.debateCode));
                    Fluttertoast.showToast(
                      msg: "Debattencode in Zwischenablage kopiert.",
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.grey,
                      timeInSecForIos: 2
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    Share.share('Disktiere in der Debatte ' + args?.debate?.topic + ' mit!\nhttps://quotify-9b7z0.web.app/joinDebate/?d=' + args?.debate.debateCode);
                  },
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
