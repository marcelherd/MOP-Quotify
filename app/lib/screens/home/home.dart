import 'package:flutter/material.dart';

import 'pages/create.dart';
import 'pages/join.dart';

class Home extends StatelessWidget {

  static const routeName = '/Home';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text('Quotify'),
            ),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(text: 'Beitreten'),
                Tab(text: 'Erstellen'),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              JoinScreen(),
              CreateScreen(),
            ],
          )),
    );
  }

}
