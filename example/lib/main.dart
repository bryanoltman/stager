import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/posts_list/posts_list_page.dart';
import 'shared/api.dart';

void main() {
  runApp(const MyApp());
}

/// The main app.
class MyApp extends StatelessWidget {
  /// Creates a [MyApp].
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<Api>.value(
      value: Api(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const PostsListPage(),
      ),
    );
  }
}
