import 'dart:io';

import 'package:coolmovies/screens/movies_list_screen.dart';
import 'package:coolmovies/utils.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  await initHiveForFlutter();

  runApp(const MyApp(),);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GraphQLConfig.initializeClient(),
      child: CacheProvider(
        child: MaterialApp(
          home: MoviesListScreen(),
        ),
      ),
    );
  }
}
