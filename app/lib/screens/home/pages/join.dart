import 'package:flutter/material.dart';

class JoinScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 16),
              child: Text(
                'Anmeldung',
                style: DefaultTextStyle.of(context)
                    .style
                    .apply(fontSizeFactor: 2.0),
              ),
            ),
            TextField(
              autofocus: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Redecode',
              ),
            ),
            Row(children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: RaisedButton(
                    child: Text('Enter'),
                    color: Colors.lightBlue,
                    onPressed: () {},
                  ),
                ),
                flex: 3,
              ),
              Expanded(
                child: RaisedButton(
                  child: Text('Re-Enter'),
                  onPressed: () {},
                ),
                flex: 1,
              ),
            ])
          ],
        ),
      ),
    );
  }
}
