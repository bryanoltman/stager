// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StagerAppGenerator
// **************************************************************************

import 'user_detail_page_scenes.dart';

import 'package:flutter/material.dart';
import 'package:stager/stager.dart';

Future<void> main() async {
  final scenes = [
    LoadingUserDetailPageScene(),
    EmptyUserDetailPageScene(),
    WithPostsUserDetailPageScene(),
    ComplexUserDetailPageScene(),
  ];

  if (const String.fromEnvironment('Scene').isNotEmpty) {
    const sceneName = String.fromEnvironment('Scene');
    final scene = scenes.firstWhere((scene) => scene.title == sceneName);
    await scene.setUp();
    runApp(StagerApp(scenes: [scene]));
  } else {
    runApp(StagerApp(scenes: scenes));
  }
}
