// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StagerAppGenerator
// **************************************************************************

import 'posts_list_scenes.dart';

import 'package:stager/stager.dart';

Future<void> main() async {
  final scenes = [
    EmptyListScene(),
    WithPostsScene(),
    LoadingScene(),
    ErrorScene(),
  ];

  if (const String.fromEnvironment('Scene').isNotEmpty) {
    const sceneName = String.fromEnvironment('Scene');
    final scene = scenes.firstWhere((scene) => scene.title == sceneName);
    runStagerApp(scenes: [scene]);
  } else {
    runStagerApp(scenes: scenes);
  }
}
