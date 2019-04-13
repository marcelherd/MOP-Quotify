import 'package:flutter/material.dart';

import 'package:app/widgets/copy_text_field.dart';

import 'debate_arguments.dart';
import 'pages/overview.dart';
import 'pages/statistics.dart';

class Debate extends StatelessWidget {
  static const routeName = '/Debate';

  // TODO(marcelherd): Use showModalBottomSheet instead of AlertDialog
  Future<void> _onPressShare(BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Debatte teilen'),
          content: Column(
            children: <Widget>[
              CopyTextField(
                scaffoldKey: scaffoldKey,
                text: 'Vho2WzK9',
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Schließen'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final DebateArguments args = ModalRoute.of(context).settings.arguments;
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Row(
              children: <Widget>[
                Expanded(child: Text(args.topic)),
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () => _onPressShare(context, _scaffoldKey),
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
