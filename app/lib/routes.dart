import 'package:flutter/material.dart';

import 'screens/home/index.dart';

class Routes {

  final routes = <String, WidgetBuilder>{
    '/Home': (BuildContext context) => new Home(),
  };

  Routes() {
    runApp(new MaterialApp(
      title: 'Quotify App',
      routes: routes,
      home: new Home(),
    ));
  }

}