import 'package:flutter/material.dart';

class SocialShareButton extends StatelessWidget {
  final Color color;
  final String text;
  final Icon icon;
  final VoidCallback callback;

  SocialShareButton({Key key, this.color, this.text, this.icon, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Ink(
            decoration:
                ShapeDecoration(color: this.color, shape: CircleBorder()),
            child: IconButton(
              icon: this.icon,
              color: Colors.white,
              onPressed: this.callback,
            ),
          ),
          SizedBox(height: 6),
          Text(this.text),
        ],
      ),
    );
  }
}
