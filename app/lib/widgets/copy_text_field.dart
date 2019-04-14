import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyTextField extends StatefulWidget {
  final String text;

  CopyTextField(this.text, {Key key}) : super(key: key);

  @override
  State createState() => CopyTextFieldState();
}

class CopyTextFieldState extends State<CopyTextField> {
  TextEditingController _textEditingController;
  Color _textFieldColor;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(
      text: widget.text,
    );
  }

  void _onTapTextField(BuildContext context) {
    Clipboard.setData(ClipboardData(
      text: widget.text,
    ));
    
    // TODO(marcelherd): Maybe some kind of animation would be cool here, but not necessary
    setState(() {
      _textEditingController.text = 'Redecode kopiert!';
      _textFieldColor = Colors.green[100];
    });
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
              fillColor: _textFieldColor,
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
