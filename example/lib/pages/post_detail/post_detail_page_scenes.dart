import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stager/stager.dart';

import '../../shared/post.dart';
import 'post_detail_page.dart';

/// A scene demonstrating a [PostDetailPage] with content.
class PostDetailPageScene extends Scene {
  static const String _currentPostKey = 'currentPost';

  @override
  Future<void> setUp(EnvironmentState environmentState) async {
    super.setUp(environmentState);
    environmentState.setDefault(
      key: _currentPostKey,
      value: Post.fakePosts().first,
    );
  }

  @override
  String get title => 'Post Detail';

  /// This [Scene] overrides the otional [environmentControlBuilders] getter to
  /// add a custom control to the Stager environment control panel.
  @override
  List<EnvironmentControlBuilder> get environmentControlBuilders =>
      <EnvironmentControlBuilder>[
        (_, EnvironmentState state) {
          return DropdownControl<Post>(
              value: state.get<Post>(key: _currentPostKey)!,
              title: const Text('Post'),
              items: Post.fakePosts(),
              onChanged: (Post? newPost) {
                if (newPost == null) {
                  return;
                }

                state.set(key: _currentPostKey, value: newPost);
              });
        },
      ];

  @override
  Widget build(BuildContext context) {
    return EnvironmentAwareApp(
      home: PostDetailPage(
        post: context.read<EnvironmentState>().get<Post>(key: _currentPostKey)!,
      ),
    );
  }
}
