import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'social_share_button.dart';

import 'package:app/widgets/copy_text_field.dart';

class ShareBottomSheet extends StatelessWidget {

  final BuildContext bottomSheetContext;

  final String _redeCode;

  ShareBottomSheet(this._redeCode, {Key key, this.bottomSheetContext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final actualContext = bottomSheetContext ?? context;

    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[],
            ),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.mail,
                  size: 64.0,
                  color: Theme.of(actualContext).primaryColor,
                ),
                Text(
                  'Debatte teilen',
                  style: TextStyle(
                    fontSize: DefaultTextStyle.of(actualContext).style.fontSize * 0.5,
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'Redecode kopieren',
                  style: TextStyle(
                    fontSize:
                        DefaultTextStyle.of(actualContext).style.fontSize * 0.25,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 8),
                CopyTextField(_redeCode),
                SizedBox(height: 32),
                Text(
                  'Einladung schicken',
                  style: TextStyle(
                    fontSize:
                        DefaultTextStyle.of(actualContext).style.fontSize * 0.25,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: <Widget>[
                    SocialShareButton(
                      text: 'WhatsApp',
                      icon: Icon(FontAwesomeIcons.whatsapp),
                      color: Colors.green,
                      callback: () {},
                    ),
                    SocialShareButton(
                      text: 'Twitter',
                      icon: Icon(FontAwesomeIcons.twitter),
                      color: Theme.of(actualContext).primaryColor,
                      callback: () {},
                    ),
                    SocialShareButton(
                      text: 'Facebook',
                      icon: Icon(FontAwesomeIcons.facebookF),
                      color: Theme.of(actualContext).primaryColorDark,
                      callback: () {},
                    ),
                    SocialShareButton(
                      text: 'SMS',
                      icon: Icon(Icons.mail),
                      color: Colors.purple,
                      callback: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
