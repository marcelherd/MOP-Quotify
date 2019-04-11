import 'package:flutter/material.dart';

import 'screens/home/index.dart';
import 'screens/debate/index.dart';

class Routes {

  final routes = <String, WidgetBuilder>{
    Home.routeName: (BuildContext context) => Home(),
    Debate.routeName: (BuildContext context) => Debate(),
  };

  Routes() {
    runApp(MaterialApp(
      title: 'Quotify App',
      routes: routes,
      home: Home(),
    ));
  }

}