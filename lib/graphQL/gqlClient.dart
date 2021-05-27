import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart';


class GraphQLConfiguration {
  static HttpLink httpLink = HttpLink(
    "https://realm.mongodb.com/api/client/v2.0/app/application-0-gzfry/graphql",
  );

  static AuthLink authLink = AuthLink(
      getToken: ()  =>  env['REALM_API_KEYS'].toString(),
      headerKey: 'apiKey'
    // OR
    // getToken: () => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
  );
  static Link link = authLink.concat(httpLink);

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: link,
      cache: GraphQLCache(store: HiveStore()),
    ),
  );


  GraphQLClient clientToQuery() {
    return GraphQLClient(
      cache: GraphQLCache(store: HiveStore()),
      link: link,
    );
  }
}



