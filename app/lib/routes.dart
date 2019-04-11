import 'package:flutter/material.dart';

import 'screens/home/index.dart';
import 'screens/debate/index.dart';

class Routes {

  final routes = <String, WidgetBuilder>{
    '/Home': (BuildContext context) => new Home(),
    '/Debate': (BuildContext context) => new Debate(),
  };

  Routes() {
    runApp(new MaterialApp(
      title: 'Quotify App',
      routes: routes,
      home: new Home(),
    ));
  }

}