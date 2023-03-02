import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:stager/stager.dart';

import '../../shared/api.dart';
import '../../shared/post.dart';
import 'posts_list_page.dart';

// #docregion PostsListPageScene
@GenerateMocks(<Type>[Api])
import 'posts_list_page_scenes.mocks.dart';

/// The [EnvironmentState] key used to set the number of posts shown by
/// [WithPostsScene].
const String numPostsKey = 'PostsListNumPosts';

/// Defines a shared build method used by subclasses and a [MockApi] subclasses
/// can use to control the behavior of the [PostsListPage].
abstract class BasePostsListScene extends Scene {
  /// A mock dependency of [PostsListPage]. Mock the value of [Api.fetchPosts]
  /// to put the staged [PostsListPage] into different states.
  late MockApi mockApi;

  @override
  Widget build(BuildContext context) {
    return EnvironmentAwareApp(
      home: Provider<Api>.value(
        value: mockApi,
        child: const PostsListPage(),
      ),
    );
  }

  @override
  Future<void> setUp(EnvironmentState environmentState) async {
    mockApi = MockApi();
  }
}

/// A Scene showing the [PostsListPage] with no [Post]s.
class EmptyListScene extends BasePostsListScene {
  @override
  String get title => 'Empty List';

  @override
  Future<void> setUp(EnvironmentState environmentState) async {
    await super.setUp(environmentState);
    when(mockApi.fetchPosts()).thenAnswer((_) async => <Post>[]);
  }
}
// #enddocregion PostsListPageScene

/// A Scene showing the [PostsListPage] with [Post]s.
class WithPostsScene extends BasePostsListScene {
  @override
  String get title => 'With Posts';

  @override
  List<EnvironmentControl<Object?>> get environmentControls =>
      <EnvironmentControl<Object?>>[
        EnvironmentControl<int>(
          stateKey: numPostsKey,
          defaultValue: Post.fakePosts().length,
          builder: (_, int currentValue, EnvironmentState state) {
            return StepperControl(
              title: const Text('# Posts'),
              value: currentValue.toString(),
              onDecrementPressed: () async {
                state.set(numPostsKey, max(0, currentValue - 1));
              },
              onIncrementPressed: () async {
                state.set(
                  numPostsKey,
                  min(currentValue + 1, Post.fakePosts().length),
                );
              },
            );
          },
        ),
      ];

  @override
  Future<void> setUp(EnvironmentState environmentState) async {
    await super.setUp(environmentState);
    when(mockApi.fetchPosts()).thenAnswer((_) async {
      return Post.fakePosts().take(environmentState.get(numPostsKey)).toList();
    });
  }
}

/// A Scene showing the [PostsListPage] in a loading state.
class LoadingScene extends BasePostsListScene {
  @override
  String get title => 'Loading';

  @override
  Future<void> setUp(EnvironmentState environmentState) async {
    await super.setUp(environmentState);
    final Completer<List<Post>> completer = Completer<List<Post>>();
    when(mockApi.fetchPosts()).thenAnswer((_) async => completer.future);
  }
}

/// A Scene showing the [PostsListPage] in a error state.
class ErrorScene extends BasePostsListScene {
  @override
  String get title => 'Error';

  @override
  Future<void> setUp(EnvironmentState environmentState) async {
    await super.setUp(environmentState);
    when(mockApi.fetchPosts()).thenAnswer(
      (_) => Future<List<Post>>.error(Exception()),
    );
  }
}
