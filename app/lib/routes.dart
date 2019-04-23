import 'package:flutter/material.dart';

import 'screens/home/index.dart';
import 'screens/session/index.dart';

class Routes {

  final routes = <String, WidgetBuilder>{
    Home.routeName: (BuildContext context) => Home(),
    Session.routeName: (BuildContext context) => Session(),
  };

  Routes() {
    runApp(MaterialApp(
      title: 'Quotify App',
      routes: routes,
      home: Home(),
    ));
  }

}