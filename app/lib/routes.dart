import 'dart:async';

import 'package:app/services/debate_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'screens/home/index.dart';
import 'screens/add_property/index.dart';
import 'screens/add_contribution/index.dart';
import 'screens/session/index.dart';
import 'screens/registration/registration.dart';
import 'package:uni_links/uni_links.dart';



class Routes {

  final routes = <String, WidgetBuilder>{
    Home.routeName: (BuildContext context) => Home(),
    Session.routeName: (BuildContext context) => Session(),
    Registration.routeName: (BuildContext context) => Registration(),
    AddProperty.routeName: (BuildContext context) => AddProperty(),
    AddContribution.routeName: (BuildContext context) => AddContribution(),
  };

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  StreamSubscription _sub;
  initPlatformStateForStringUniLinks() async {
    _sub = getLinksStream().listen((String link) {
      enterDebate(link);
    }, onError: (err) {
    });
 
    String initialLink;
    try {
      initialLink = await getInitialLink();
      enterDebate(initialLink);
    } on PlatformException {
      initialLink = 'Failed to get initial link.';
    } on FormatException {
      initialLink = 'Failed to parse the initial link as Uri.';
    }
  }
 
  enterDebate(String link) async {
    if(link != null){
      debugPrint('Got Link ' + link);
    String speechCode = '';
    if(link.contains('?d=')){
      var split = link.split('?d=');
      speechCode = split[split.length-1];
    }
    debugPrint('SpeechCode ' + speechCode);
        var debate = await DebateService.getDebate(speechCode);
 
    if (debate == null || debate.closed) {
      Fluttertoast.showToast(
        msg: "Die Debatte existiert nicht!",
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 2);
      return;
    }
 
    navigatorKey.currentState.pushNamed(Registration.routeName, arguments: debate);
    }
 
  }
 
  Routes() {
    initPlatformStateForStringUniLinks();
    debugPrint('Run');
    runApp(MaterialApp(
      title: 'Quotify App',
      routes: routes,
      home: Home(),
      navigatorKey: navigatorKey,
    ));
  }

}