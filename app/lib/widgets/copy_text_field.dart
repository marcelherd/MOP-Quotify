import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyTextField extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String text;

  CopyTextField({Key key, this.scaffoldKey, this.text}) : super(key: key);

  @override
  State createState() => CopyTextFieldState();
}

class CopyTextFieldState extends State<CopyTextField> {
  TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(
      text: widget.text,
    );
  }

  void _onTapTextField(BuildContext context) {
    Clipboard.setData(ClipboardData(
      text: _textEditingController.text,
    ));

    final snackBar = SnackBar(
      // duration: Duration(seconds: 1),
      content: Text('Redecode kopiert'),
    );
    widget.scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onTapTextField(context),
      child: Container(
        color: Colors.transparent,
        child: IgnorePointer(
          child: TextFormField(
            controller: _textEditingController,
            enabled: false,
            decoration: InputDecoration(
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(0.0)),
              ),
              suffixIcon: Icon(Icons.link),
            ),
          ),
        ),
      ),
    );
  }
}
