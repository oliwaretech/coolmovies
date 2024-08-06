
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfig {
  static final HttpLink httpLink = HttpLink(Platform.isAndroid ? 'http://10.0.2.2:5001/graphql' : 'http://localhost:5001/graphql',);

  static ValueNotifier<GraphQLClient> initializeClient() {
    final link = httpLink;

    return ValueNotifier(
      GraphQLClient(
        cache: GraphQLCache(store: HiveStore()),
        link: link,
      ),
    );
  }
}