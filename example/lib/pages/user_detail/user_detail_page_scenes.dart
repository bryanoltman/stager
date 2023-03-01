import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:stager/stager.dart';

import '../../shared/api.dart';
import '../../shared/post.dart';
import '../../shared/user.dart';
import '../posts_list/posts_list_page_scenes.mocks.dart';
import 'user_detail_page.dart';

/// The [EnvironmentState] key used to set the number of posts shown by
/// [WithPostsUserDetailPageScene] and [ComplexUserDetailPageScene].
const String numPostsKey = 'UserDetailNumPosts';

/// A Scene demonstrating the [UserDetailPage].
abstract class UserDetailPageScene extends Scene {
  /// A mock dependency of [UserDetailPage]. Mock the value of [Api.fetchPosts]
  /// to put the staged [UserDetailPage] into different states.
  late MockApi mockApi;

  /// The [User] whose information is being displayed.
  User user = User.joeUser;

  @override
  Future<void> setUp(EnvironmentState environmentState) async {
    await super.setUp(environmentState);
    mockApi = MockApi();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<Api>.value(
      value: mockApi,
      child: EnvironmentAwareApp(
        home: UserDetailPage(
          user: user,
        ),
      ),
    );
  }
}

/// A Scene showing the loading state of the [UserDetailPage].
class LoadingUserDetailPageScene extends UserDetailPageScene {
  @override
  String get title => 'Loading';

  @override
  Future<void> setUp(EnvironmentState environmentState) async {
    await super.setUp(environmentState);
    when(mockApi.fetchPosts(user: user)).thenAnswer((_) {
      final Completer<List<Post>> completer = Completer<List<Post>>();
      return completer.future;
    });
  }
}

/// A Scene showing the error state of the [UserDetailPage].
class ErrorUserDetailPageScene extends UserDetailPageScene {
  @override
  String get title => 'Error';

  @override
  Future<void> setUp(EnvironmentState environmentState) async {
    await super.setUp(environmentState);
    when(mockApi.fetchPosts(user: user)).thenAnswer(
      (_) async => Future<List<Post>>.error(
        Exception('on no!'),
      ),
    );
  }
}

/// A Scene showing the empty state of the [UserDetailPage].
class EmptyUserDetailPageScene extends UserDetailPageScene {
  @override
  String get title => 'Empty';

  @override
  Future<void> setUp(EnvironmentState environmentState) async {
    await super.setUp(environmentState);
    when(mockApi.fetchPosts(user: user)).thenAnswer((_) async => <Post>[]);
  }
}

/// A Scene showing the content state of the [UserDetailPage].
class WithPostsUserDetailPageScene extends UserDetailPageScene {
  @override
  List<EnvironmentControl<dynamic>> get environmentControls =>
      <EnvironmentControl<dynamic>>[
        EnvironmentControl<int>(
          stateKey: numPostsKey,
          defaultValue: 20,
          builder: (_, EnvironmentState state) => StepperControl(
            title: const Text('Post Count'),
            value: state.get<int>(numPostsKey).toString(),
            onDecrementPressed: () {
              state.set(
                numPostsKey,
                max(0, state.get<int>(numPostsKey)! - 1),
              );
            },
            onIncrementPressed: () {
              state.set(
                numPostsKey,
                min(20, state.get<int>(numPostsKey)! + 1),
              );
            },
          ),
        ),
      ];

  @override
  String get title => 'With posts';

  @override
  Future<void> setUp(EnvironmentState environmentState) async {
    await super.setUp(environmentState);
    when(mockApi.fetchPosts(user: user)).thenAnswer(
      (_) async => Post.fakePosts(user: user)
          .take(environmentState.get<int>(numPostsKey)!)
          .toList(),
    );
  }
}

/// A Scene showing the [UserDetailPage] for a [User] with a long name.
class ComplexUserDetailPageScene extends UserDetailPageScene {
  @override
  List<EnvironmentControl<dynamic>> get environmentControls =>
      <EnvironmentControl<dynamic>>[
        EnvironmentControl<int>(
          stateKey: numPostsKey,
          defaultValue: 20,
          builder: (_, EnvironmentState state) => StepperControl(
            title: const Text('Post Count'),
            value: state.get<int>(numPostsKey).toString(),
            onDecrementPressed: () {
              state.set(numPostsKey, max(0, state.get<int>(numPostsKey)! - 1));
            },
            onIncrementPressed: () {
              state.set(numPostsKey, min(20, state.get<int>(numPostsKey)! + 1));
            },
          ),
        ),
      ];

  @override
  String get title => 'User with long name';

  @override
  Future<void> setUp(EnvironmentState environmentState) async {
    await super.setUp(environmentState);
    user = const User(
      id: 1234,
      handle: '@asdf',
      name: 'Super cool poster with great hot takes',
    );
    when(mockApi.fetchPosts(user: user)).thenAnswer(
      (_) async => Post.fakePosts()
          .take(environmentState.get<int>(numPostsKey)!)
          .toList(),
    );
  }
}
