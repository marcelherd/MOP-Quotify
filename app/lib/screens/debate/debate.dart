import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        return Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[],
                ),
                child: Column(
                  children: <Widget>[
                    Icon(Icons.mail,size: 64.0,color: Theme.of(context).primaryColor,),
                    Text(
                      'Debatte teilen',
                      style: TextStyle(
                        fontSize: DefaultTextStyle.of(context).style.fontSize * 0.5,
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Redecode kopieren',
                      style: TextStyle(
                        fontSize: DefaultTextStyle.of(context).style.fontSize * 0.25,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8),
                    CopyTextField('Vho2WzK9'),
                    SizedBox(height: 32),
                    Text(
                      'Einladung schicken',
                      style: TextStyle(
                        fontSize: DefaultTextStyle.of(context).style.fontSize * 0.25,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Ink(
                                decoration: ShapeDecoration(
                                  color: Colors.green,
                                  shape: CircleBorder()
                                ),
                                child: IconButton(
                                  icon: Icon(FontAwesomeIcons.whatsapp),
                                  color: Colors.white,
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(height: 6),
                              Text('WhatsApp'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Ink(
                                decoration: ShapeDecoration(
                                  color: Theme.of(context).primaryColor,
                                  shape: CircleBorder()
                                ),
                                child: IconButton(
                                  icon: Icon(FontAwesomeIcons.twitter),
                                  color: Colors.white,
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(height: 6),
                              Text('Twitter'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Ink(
                                decoration: ShapeDecoration(
                                  color: Theme.of(context).primaryColorDark,
                                  shape: CircleBorder()
                                ),
                                child: IconButton(
                                  icon: Icon(FontAwesomeIcons.facebookF),
                                  color: Colors.white,
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(height: 6),
                              Text('Facebook'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Ink(
                                decoration: ShapeDecoration(
                                  color: Colors.purple,
                                  shape: CircleBorder()
                                ),
                                child: IconButton(
                                  icon: Icon(Icons.mail),
                                  color: Colors.white,
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(height: 6),
                              Text('SMS'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
