import 'package:flutter/material.dart';
import 'package:zefyr/zefyr.dart';

class RichTextEdit extends StatelessWidget {
  const RichTextEdit(this.controller, this.focus, {Key key}) : super(key: key);
  final ZefyrController controller;
  final FocusNode focus;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ZefyrScaffold(
        child: ZefyrEditor(
          padding: EdgeInsets.all(16.0),
          controller: controller,
          focusNode: focus,
        ),
      ),
    );
  }
}