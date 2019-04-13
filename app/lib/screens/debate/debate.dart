import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'debate_arguments.dart';
import 'pages/overview.dart';
import 'pages/statistics.dart';

class Debate extends StatelessWidget {

  static const routeName = '/Debate';

  final _textEditingController = TextEditingController(
    text: 'Vho2WzK9'
  );

  void _onTapTextField(BuildContext context) {
    Clipboard.setData(ClipboardData(
      text: _textEditingController.text,
    ));

    debugPrint('Redecode kopiert: ${_textEditingController.text}');

    // Requires global key: https://gist.github.com/branflake2267/7bf49fc232743d0cacfb90e8aa71467d
    // Requires rewriting Debate to be a StatefulWidget. ShareDialog should be extracted into a separate widget as well.
    // TOOD(marcelherd): Try showModalBottomSheet instead

    // final snackBar = SnackBar(content: Text('Redecode kopiert'));
    // Scaffold.of(context).showSnackBar(snackBar);
  }

  Future<void> _onPressShare(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Debatte teilen'),

          content: Column(
            children: <Widget>[
              InkWell(
                onTap: () => _onTapTextField(context),
                child: Container(
                  color: Colors.transparent,
                  child: IgnorePointer(
                    child: TextFormField(
                      controller: _textEditingController,
                      enabled: false,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0.0)),
                        ),
                        suffixIcon: Icon(Icons.link),
                      ),
                    ),
                  ),
                ),
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
