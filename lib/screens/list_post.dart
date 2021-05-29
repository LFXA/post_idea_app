import "package:flutter/material.dart";
import "package:graphql_flutter/graphql_flutter.dart";
import 'package:post_idea_app/graphQL/gqlClient.dart';
import 'package:post_idea_app/graphQL/query_mutation.dart';
import 'package:post_idea_app/models/post.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:post_idea_app/screens/post_detail.dart';

class ListPost extends StatefulWidget {
  const ListPost({Key key}) : super(key: key);

  @override
  _ListPostState createState() => _ListPostState();
}

class _ListPostState extends State<ListPost> {
  var listPost = <Post>[];
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

  Future fillList() async {
    QueryMutation queryMutation = QueryMutation();
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    listPost.clear();
    QueryResult result = await _client.query(
      QueryOptions(
        document: listPost.length == 0 ? gql(queryMutation.getAll()) : gql(queryMutation.getNotInID(listPost.map((e)=> "\"${e.id}\"").toList())),
      ),
    );
    if (!result.hasException) {
      for (var i = 0; i < result.data["posts"].length; i++) {
        setState(() {
          listPost.add(
            Post(
                result.data["posts"][i]["_id"],
                result.data["posts"][i]["author"],
                result.data["posts"][i]["category"],
                result.data["posts"][i]["content"],
                DateTime.tryParse(result.data["posts"][i]["created"]?? new DateTime(DateTime.now().year).toIso8601String()),
                result.data["posts"][i]["excerpt"],
                result.data["posts"][i]["image"],
                result.data["posts"][i]["image_caption"],
                result.data["posts"][i]["lang"],
                result.data["posts"][i]["path"],
                result.data["posts"][i]["tags"],
                result.data["posts"][i]["title"]),
          );
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fillList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () => {},
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Posts",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30.0),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 50.0),
            child: Center(
              child: RefreshIndicator(
                onRefresh: fillList,
                child: ListView.builder(
                  itemCount: listPost.length,
                  itemBuilder: (context, index) {

                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      child: ListTile(
                        selected: listPost == null ? false : true,

                        contentPadding: EdgeInsets.all(16.0),
                        title: Text(
                          "${listPost[index].title}",
                          maxLines: 2,
                          style: TextStyle(color: Colors.black),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0, 0),
                          child: Text(
                            '${htmlparser.parse("${listPost[index].content??''}").body.text}',
                            style:
                                TextStyle(fontSize: 12.0, color: Colors.black),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  PostDetail(listPost[index])));
                        },
                        trailing:listPost[index].image !=null? Image.network(
                          listPost[index].image?? '',
                          fit: BoxFit.cover,
                          width: 80.0,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) return child;
                            return CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes
                                  : null,
                            );
                          },
                        ) : Text('imagem'),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
