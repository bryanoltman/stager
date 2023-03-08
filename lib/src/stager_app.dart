/*
 Copyright 2023 Google LLC

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

      https://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import 'package:flutter/material.dart';

import 'scene.dart';
import 'scene_container.dart';
import 'scene_list.dart';

/// A convenience method to run [scenes] in a [StagerApp].
void runStagerApp({required List<Scene> scenes}) =>
    runApp(StagerApp(scenes: scenes));

/// A simple app that displays a list of [Scene]s and navigates to them on tap.
///
/// If only one Scene is provided, that Scene will be shown as though it had
/// been navigated to from a list of Scenes.
class StagerApp extends StatefulWidget {
  /// Creates a [StagerApp] with the given [scenes].
  const StagerApp({super.key, required this.scenes});

  /// The [Scene]s being displayed by this app.
  final List<Scene> scenes;

  @override
  State<StagerApp> createState() => _StagerAppState();
}

class _StagerAppState extends State<StagerApp> {
  late Future<void> _sceneSetUpFuture;

  bool get _isSingleScene => widget.scenes.length == 1;

  @override
  void initState() {
    super.initState();
    if (_isSingleScene) {
      _sceneSetUpFuture = widget.scenes.first.setUp();
    } else {
      _sceneSetUpFuture = Future<void>.value();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _sceneSetUpFuture,
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return MaterialApp(
          home: _isSingleScene
              ? SceneContainer(scene: widget.scenes.first)
              : SceneList(scenes: widget.scenes),
        );
      },
    );
  }
}
