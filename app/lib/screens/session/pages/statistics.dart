import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:url_launcher/url_launcher.dart';

import 'package:app/models/debate.dart';
import 'package:app/services/debate_service.dart';

class StatisticsScreen extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate = false;
  final Debate _debate;
  final Author author;

  StatisticsScreen(this._debate, {this.author}) : seriesList = _createSampleData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
        child: Center(
            child: charts.PieChart(seriesList,
                animate: animate,
                defaultRenderer: charts.ArcRendererConfig(
                    arcWidth: 100,
                    arcRendererDecorators: [charts.ArcLabelDecorator()]))),
      ),
      persistentFooterButtons: author != null ? <Widget>[
        RaisedButton(
          child: Text('Export', style: TextStyle(color: Colors.white)),
          color: Theme.of(context).primaryColor,
          onPressed: () async {
            final url = 'https://quotify-9b7z0.firebaseapp.com/?d=${_debate.debateCode}';
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
          }),
        RaisedButton(
          child: Text('Debatte schließen', style: TextStyle(color: Colors.white)),
          color: Theme.of(context).errorColor,
          onPressed: () {
            DebateService.closeDebate(_debate.debateCode);
            Navigator.pushNamed(context, '/Home');
          }),
      ] : null,
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      LinearSales(0, 100),
      LinearSales(1, 75),
      LinearSales(2, 25),
      LinearSales(3, 5),
    ];

    return [
      charts.Series<LinearSales, int>(
          id: 'Sales',
          domainFn: (LinearSales sales, _) => sales.year,
          measureFn: (LinearSales sales, _) => sales.sales,
          data: data,
          labelAccessorFn: (LinearSales row, _) => '${row.year}: ${row.sales}')
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
