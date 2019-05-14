import 'dart:async';

import 'package:app/models/debate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TimerBottomSheet extends StatefulWidget {

  final Contribution _contribution;

  TimerBottomSheet(this._contribution, {Key key}) : super(key: key);

  _TimerBottomSheetState createState() => _TimerBottomSheetState();
}

class _TimerBottomSheetState extends State<TimerBottomSheet> {

  Timer _timer;
  DateTime _startTime;
  DateTime _currentTime;
  Duration _previous = Duration();

  void _onPressStart() {
    _startTime = DateTime.now();

    const duration = const Duration(milliseconds: 10);
    _timer = Timer.periodic(duration, (Timer timer) {
      setState(() => _currentTime = DateTime.now());
    });
  }

  void _onPressStop() {
    _timer.cancel();
    _previous = _previous + Duration(milliseconds: _currentTime.millisecondsSinceEpoch - _startTime.millisecondsSinceEpoch);
  }

  void _onPressArchive() {

  }
  @override
  Widget build(BuildContext context) {
    var timerText = '00:00.00';

    if (_startTime != null) {
      var difference = _currentTime.millisecondsSinceEpoch - _startTime.millisecondsSinceEpoch;
      var duration = Duration(milliseconds: difference) + _previous;
      var milliseconds = duration.inMilliseconds % 1000;
      var seconds = duration.inSeconds % 60;
      var minutes = duration.inMinutes;
      timerText = '${minutes < 10 ? 0 : ''}$minutes:${seconds < 10 ? 0 : ''}$seconds.${milliseconds.toString().substring(0, 2)}';
    }

    var firstButtonText = 'Starten';
    var firstButtonColor = Colors.deepPurple;
    var firstButtonHandler = _onPressStart;

    if (_timer != null && _timer.isActive) {
      firstButtonText = 'Stoppen';
      firstButtonColor = Colors.red;
      firstButtonHandler = _onPressStop;
    } else if (_startTime != null) {
      firstButtonText = 'Fortsetzen';
      firstButtonColor = Theme.of(context).primaryColor;
      firstButtonHandler = _onPressStart;
    }

    return Container(
      color: Colors.black87,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 4.0, bottom: 12.0),
                      child: Text('${widget._contribution.author.name} - ${widget._contribution.content}',
                        style: DefaultTextStyle.of(context).style.apply(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: RaisedButton(
                            color: firstButtonColor,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            child: Text(firstButtonText),
                            onPressed: firstButtonHandler,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(timerText,
                            style: DefaultTextStyle.of(context).style.apply(
                              fontSizeFactor: 2,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: RaisedButton(
                            disabledColor: Colors.transparent,
                            disabledTextColor: Colors.transparent,
                            textColor: Colors.white,
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            child: Text('Speichern'),
                            onPressed: _startTime == null ? null : _onPressArchive,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}