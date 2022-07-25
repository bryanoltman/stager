import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:stager/stager.dart';

import '../shared/api.dart';
import '../shared/post.dart';
import 'posts_list.dart';

import 'posts_list_scenes.mocks.dart';

@GenerateMocks([Api])
abstract class BasePostsListScene extends Scene {
  late MockApi mockApi;

  @override
  Widget build() {
    return Builder(builder: (context) {
      // If we already have a navigator, do not wrap this widget in a
      // MaterialApp.
      bool hasNavigator = true;
      try {
        final _ = Navigator.of(context);
      } on FlutterError {
        hasNavigator = false;
      }

      final widget = Provider<Api>.value(
        value: mockApi,
        child: const PostsList(),
      );

      if (hasNavigator) {
        return widget;
      }

      return MaterialApp(
        home: widget,
      );
    });
  }

  @override
  Future<void> setUp() async {
    mockApi = MockApi();
  }
}

class EmptyListScene extends BasePostsListScene {
  @override
  String get title => 'Empty List';

  @override
  Future<void> setUp() async {
    await super.setUp();
    when(mockApi.fetchPosts()).thenAnswer((_) async => []);
  }
}

class WithPostsScene extends BasePostsListScene {
  @override
  String get title => 'With Posts';

  @override
  Future<void> setUp() async {
    await super.setUp();
    when(mockApi.fetchPosts()).thenAnswer((_) async => Post.fakePosts);
  }
}

class LoadingScene extends BasePostsListScene {
  @override
  String get title => 'Loading';

  @override
  Future<void> setUp() async {
    await super.setUp();
    final completer = Completer<List<Post>>();
    when(mockApi.fetchPosts()).thenAnswer((_) async => completer.future);
  }
}

class ErrorScene extends BasePostsListScene {
  @override
  String get title => 'Error';

  @override
  Future<void> setUp() async {
    await super.setUp();
    when(mockApi.fetchPosts()).thenAnswer((_) => Future.error(Exception()));
  }
}
