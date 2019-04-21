import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class StatisticsScreen extends StatelessWidget {
   List<charts.Series> seriesList;
   bool animate = false;


  @override
  Widget build(BuildContext context) {
   
    seriesList = _createSampleData();
    
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
        child: Center(
          child: new charts.PieChart(seriesList, 
          animate: animate,
          defaultRenderer: new charts.ArcRendererConfig(
              arcWidth: 100,
              arcRendererDecorators: [new charts.ArcLabelDecorator()]))
        ), 
      ),
      floatingActionButton: RaisedButton(
                  child: Text('Close Debate', style: TextStyle(color: Colors.white)),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {

                    //TODO delete debate code in backend.
                    Navigator.pushNamed(context, '/Home');
                  }
               ),      
    );   
    
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 100),
      new LinearSales(1, 75),
      new LinearSales(2, 25),
      new LinearSales(3, 5),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
        labelAccessorFn: (LinearSales row, _) => '${row.year}: ${row.sales}'
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}