import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  final String endpoint =
      'https://countries.trevorblades.com/graphql'; // GitHub GraphQL API endpoint

  String currentQuery = '''{
  countries {
    name
  }
}''';

  Future<dynamic> query() async {
    final HttpLink httpLink = HttpLink(endpoint);

    final GraphQLClient client = GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
    );

    final QueryOptions options = QueryOptions(
      document: gql(currentQuery),
    );

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw Exception(result.exception!.toString());
    }

    print(result.data!['countries']);

    return result.data!;
  }
}
