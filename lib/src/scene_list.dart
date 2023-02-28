import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'environment/state/environment_state.dart';
import 'scene.dart';
import 'scene_container.dart';

/// A [ListView] showing available [Scenes]. Tapping on a Scene name will setUp
/// the Scene before displaying it.
class SceneList extends StatefulWidget {
  /// Creates a [SceneList] widget.
  const SceneList({super.key, required this.scenes});

  /// The list of [Scene]s displayed by this widget.
  final List<Scene> scenes;

  @override
  State<SceneList> createState() => _SceneListState();
}

class _SceneListState extends State<SceneList> {
  @override
  Widget build(BuildContext context) {
    final EnvironmentState state = context.read<EnvironmentState>();

    return Scaffold(
      appBar: AppBar(title: const Text('Scenes')),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          final Scene scene = widget.scenes[index];
          return ListTile(
            title: Text(widget.scenes[index].title),
            onTap: () async {
              await scene.setUp(state);
              if (!mounted) {
                return;
              }

              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => SceneContainer(scene: scene),
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
