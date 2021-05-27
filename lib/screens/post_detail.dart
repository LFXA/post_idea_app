import "package:flutter/material.dart";
import 'package:flutter_html/flutter_html.dart';
import 'package:post_idea_app/models/post.dart';
import 'package:post_idea_app/screens/post_edit.dart';

class PostDetail extends StatelessWidget {
  const PostDetail(this.post, {Key key}) : super(key: key);
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalhe',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => PostEdit(post)),
              )
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                post.title??'',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 50.0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 0),
              child: Html(
                data: post.content??'',
              ),
            ),
          )
        ]),
      ),
    );
  }
}
