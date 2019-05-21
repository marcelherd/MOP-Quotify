import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:url_launcher/url_launcher.dart';

import 'package:app/models/debate.dart';
import 'package:app/services/debate_service.dart';
import 'package:app/screens/home/index.dart';

class StatisticsScreen extends StatefulWidget {
  final Debate _debate;
  final Author author;

  StatisticsScreen(this._debate, {this.author});

  @override
  State<StatefulWidget> createState() => _StatisticsScreenState(_debate, author: this.author);

}

class _StatisticsScreenState extends State<StatisticsScreen> {

  final bool animate = true;
  final Debate _debate;
  final Author author;
  _StatisticsScreenState(this._debate, {this.author});

  void _onPressExport() async {
    final url = 'https://quotify-9b7z0.firebaseapp.com/?d=${_debate.debateCode}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _onPressCloseDebate(BuildContext context) {
    showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Debatte schließen'),
        content: Text('Soll die Debatte wirklich geschlossen werden? Dieser Vorgang ist unwiderruflich. Ein erneutes Beitreten der Debatte ist nicht möglich.'),
        actions: <Widget>[
          FlatButton(
            child: Text('Abbrechen'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          RaisedButton(
            color: Colors.red,
            child: Text('Debatte schließen', style: TextStyle(color: Colors.white)),
            onPressed: () {
              DebateService.closeDebate(_debate.debateCode);
              Navigator.pushNamedAndRemoveUntil(context, Home.routeName, ModalRoute.withName('/'));
            },
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
        child: Center(
            child: StreamBuilder(
            stream: Firestore.instance
              .collection(widget._debate.debateCode)
              .orderBy('archived')
              .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Text('Loading...');
              return _fetchDataAsStream(snapshot);
            },
          ),
        ),
      ),
      persistentFooterButtons: author == null ? <Widget>[
        RaisedButton(
          child: Text('Export', style: TextStyle(color: Colors.white)),
          color: Theme.of(context).primaryColor,
          onPressed: _onPressExport,
        ),
        RaisedButton(
          child: Text('Debatte schließen', style: TextStyle(color: Colors.white)),
          color: Theme.of(context).errorColor,
          onPressed: () => _onPressCloseDebate(context),
        ),
      ] : null,
    );
  }

    Widget _fetchDataAsStream(AsyncSnapshot<dynamic> snapshot) {
    
    Map<String, int> propertyCounter = new Map<String, int>();
    propertyCounter["Männlich"] = 0;
    propertyCounter["Weiblich"] = 0;
    propertyCounter["Divers"] = 0;
    _debate.customProperties.forEach((k, v) {
      if(v.length > 0){
        v.forEach((value) {
          propertyCounter[value.toString()] = 0;
        });
      }else{
        propertyCounter[k] = 0;
        propertyCounter["Nicht " + k] = 0;
      }
    });
    
    double fullTime = 0;
    snapshot.data.documents.forEach((DocumentSnapshot document) {
      if(document.documentID != 'metadata'){
        Contribution c = Contribution.fromJson(document.data, document.documentID);
        switch(c.author.gender){
          case Gender.male:
            propertyCounter["Männlich"]+=c.duration.round();
            break;
          case Gender.female:
            propertyCounter["Weiblich"]+=c.duration.round();
            break;
          case Gender.diverse:
            propertyCounter["Divers"]+=c.duration.round();
        }
        c.author.customProperties.forEach((k, v) {
          if(v is bool){
            if(v){
              propertyCounter[k] += c.duration.round();
            }else{
              propertyCounter["Nicht " + k]+=c.duration.round();
            }
          }else{
            propertyCounter[v.toString()]+= c.duration.round();
          }
        });
        fullTime += c.duration.round();
      }
    });
    if(fullTime > 0){
      List<QuotedContribution> data = [];
      propertyCounter.forEach((String k, int v) {
        data.add(QuotedContribution(k, (v / fullTime*100).round()));
      });
      return charts.PieChart(
                      [
                        charts.Series<QuotedContribution, String>(
                        id: "Contributions", 
                        domainFn: (QuotedContribution contrib, _) => contrib.propertyName,
                        measureFn: (QuotedContribution contrib, _) => contrib.count,
                        data: data,
                        labelAccessorFn: (QuotedContribution contrib, _) => '${contrib.propertyName} - ${contrib.count}%',
                        )
                      ],
                      animate: animate,
                      defaultRenderer: new charts.ArcRendererConfig(arcRendererDecorators: [
                        new charts.ArcLabelDecorator(
                            labelPosition: charts.ArcLabelPosition.auto,
                            insideLabelStyleSpec: charts.TextStyleSpec(fontSize: 9)
                            )
                      ]),
                    );
    }else {
      return Text("Keine Wortmeldungen für die Statistik verfügbar!");
    }

  }

}

  class QuotedContribution {
    final String propertyName;
    final int count;

    QuotedContribution(this.propertyName, this.count);
  }