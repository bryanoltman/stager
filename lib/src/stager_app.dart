import 'package:flutter/material.dart';

import 'scene.dart';
import 'scene_container.dart';

Future<void> runStagerApp({required List<Scene> scenes}) async {
  if (scenes.length == 1) {
    final scene = scenes.first;
    await scene.setUp();
    runApp(StagerApp(scenes: [scene]));
  } else {
    runApp(StagerApp(scenes: scenes));
  }
}

/// A simple app that displays a list of [Scene]s and navigates to them on tap.
///
/// If only one Scene is provided, that Scene will be shown as though it had
/// been navigated to from a list of Scenes.
class StagerApp extends StatelessWidget {
  final List<Scene> scenes;

  const StagerApp({super.key, required this.scenes});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SceneList(
        scenes: scenes,
      ),
    );
  }
}

class SceneList extends StatefulWidget {
  final List<Scene> scenes;

  SceneList({super.key, required this.scenes});

  @override
  State<SceneList> createState() => _SceneListState();
}

class _SceneListState extends State<SceneList> {
  @override
  Widget build(BuildContext context) {
    if (widget.scenes.length == 1) {
      return SceneContainer(
        child: widget.scenes.first.build(),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Scenes')),
      body: ListView.separated(
        itemBuilder: (context, index) {
          final scene = widget.scenes[index];
          return ListTile(
            title: Text(widget.scenes[index].title),
            onTap: () async {
              await scene.setUp();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => SceneContainer(
                    child: scene.build(),
                  ),
                ),
              );
            },
          );
        },
        separatorBuilder: (_, __) => const Divider(),
        itemCount: widget.scenes.length,
      ),
    );
  }
}
