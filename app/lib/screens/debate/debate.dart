import 'package:flutter/material.dart';

import 'package:app/widgets/copy_text_field.dart';

import 'debate_arguments.dart';
import 'pages/overview.dart';
import 'pages/statistics.dart';

class Debate extends StatelessWidget {
  static const routeName = '/Debate';

  Future<void> _onPressShare(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Text(
                'Redecode teilen',
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              SizedBox(height: 16),
              CopyTextField('Vho2WzK9'),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final DebateArguments args = ModalRoute.of(context).settings.arguments;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: <Widget>[
                Expanded(child: Text(args.topic)),
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
