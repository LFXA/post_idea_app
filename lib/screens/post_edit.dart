import 'dart:convert';
import "package:flutter/material.dart";
import 'package:flutter_html/flutter_html.dart';
import 'package:markdown/markdown.dart' as markdown;
import 'package:post_idea_app/components/edit_save_dialog.dart';
import 'package:post_idea_app/components/rich_text_edit.dart';
import 'package:post_idea_app/models/post.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:quill_markdown/quill_markdown.dart';
import 'package:quill_zefyr_bijection/quill_zefyr_bijection.dart';
import 'package:zefyr/zefyr.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:html/parser.dart' as htmlparser;

class PostEdit extends StatefulWidget {
  final Post post;

  const PostEdit(this.post, {Key key}) : super(key: key);

  @override
  _PostEditState createState() => _PostEditState(post);
}

class _PostEditState extends State<PostEdit> {
  ZefyrController controller;
  FocusNode focus;

  final Post post;

  _PostEditState(this.post);

  @override
  void initState() {
    super.initState();
    controller = ZefyrController(NotusDocument());
    if (post.content != null) {
      final document = _loadDocument();
      controller = ZefyrController(document);
    }
    focus = FocusNode();
  }

  NotusDocument _loadDocument() {

    final Delta delta = QuillZefyrBijection.convertJSONToZefyrDelta(
        '{\"ops\": ${markdownToQuill(html2md.convert(post.content,styleOptions: {'headingStyle': 'atx'}))}}');
    return NotusDocument.fromDelta(delta);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editor"),
        actions: [
          TextButton(
              onPressed: () {
               var content = markdown.markdownToHtml(quillToMarkdown(
                    jsonEncode(controller.document.toDelta())));
                showDialog(
                    context: context,
                    builder: (contextDialog) {
                      return EditSaveDialog(post, content);
                    });

                print('html: ' + '${post.content}');
                print('MK: '                    );
              },
              child: Text(
                'Publicar',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: RichTextEdit(controller, focus)
    );
  }
}
