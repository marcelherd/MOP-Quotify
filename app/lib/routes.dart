import 'package:flutter/material.dart';

import 'screens/home/index.dart';
import 'screens/add_property/index.dart';
import 'screens/session/index.dart';
import 'screens/registration/registration.dart';

class Routes {

  final routes = <String, WidgetBuilder>{
    Home.routeName: (BuildContext context) => Home(),
    Session.routeName: (BuildContext context) => Session(),
    Registration.routeName: (BuildContext context) => Registration(),
    AddProperty.routeName: (BuildContext context) => AddProperty(),
  };

  Routes() {
    runApp(MaterialApp(
      title: 'Quotify App',
      routes: routes,
      home: Home(),
    ));
  }

}