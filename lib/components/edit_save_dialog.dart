import 'package:flutter/material.dart';
import 'package:post_idea_app/models/post.dart';

class EditSaveDialog extends StatefulWidget {
  final Post post;
  final String content;

  const EditSaveDialog(this.post, this.content, {Key key}) : super(key: key);

  @override
  _EditSaveDialogState createState() => _EditSaveDialogState(post, content);
}

class _EditSaveDialogState extends State<EditSaveDialog> {
  final Post post;
  final String content;

  _EditSaveDialogState(this.post, [this.content]);

  final TextEditingController titleController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController excerptController = TextEditingController();
  final TextEditingController langController = TextEditingController();
  final TextEditingController pathController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Dados'),
      content: SingleChildScrollView(
        child: Row(children: <Widget>[
          Expanded(
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buildTextFormField(titleController, 'Título',
                        lines: 2, text: post.title),
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: buildTextFormField(
                              categoryController, 'Categoria',
                              text: post.category),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: buildTextFormField(authorController, 'Autor',
                              text: post.author),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buildTextFormField(excerptController, 'Trecho',
                        lines: 3, text: post.excerpt),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: buildTextFormField(contentController, 'Conteúdo',
                          lines: null,
                          text: content
                              .replaceAllMapped(
                                  RegExp("<ol*"),
                                  (match) =>
                                      "${match.group(0)} class=\"list-decimal list-inside\"")
                              .replaceAllMapped(
                                  RegExp("<ul*"),
                                  (match) =>
                                      "${match.group(0)} class=\"list-disc list-inside\""))),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 48.0,
                            child: buildTextFormField(langController, 'Língua',
                                text: post.lang),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: buildTextFormField(pathController, 'Path',
                              text: post.path),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Confirm'),
        ),
      ],
    );
  }

  TextFormField buildTextFormField(
      TextEditingController controller, String label,
      {int lines = 1, String text}) {
    controller.text = text;
    return TextFormField(
      controller: controller,
      maxLines: lines,
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.text,
    );
  }
}