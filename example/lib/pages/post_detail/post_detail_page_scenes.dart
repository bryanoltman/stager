import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stager/stager.dart';

import '../../shared/post.dart';
import 'post_detail_page.dart';

/// A scene demonstrating a [PostDetailPage] with content.
class PostDetailPageScene extends Scene {
  static const String _currentPostKey = 'currentPost';

  @override
  String get title => 'Post Detail';

  /// This [Scene] overrides the otional [environmentControlBuilders] getter to
  /// add a custom control to the Stager environment control panel.
  @override
  List<EnvironmentControl<dynamic>> get environmentControls =>
      <EnvironmentControl<dynamic>>[
        EnvironmentControl<Post>(
          stateKey: _currentPostKey,
          defaultValue: Post.fakePosts().first,
          builder: (_, Post post, EnvironmentState state) {
            return DropdownControl<Post>(
              value: post,
              title: const Text('Post'),
              items: Post.fakePosts(),
              onChanged: (Post? newPost) {
                if (newPost == null) {
                  return;
                }

                state.set(_currentPostKey, newPost);
              },
            );
          },
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return EnvironmentAwareApp(
      home: PostDetailPage(
        post: context.read<EnvironmentState>().get<Post>(_currentPostKey)!,
      ),
    );
  }
}
