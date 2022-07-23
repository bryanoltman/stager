import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'scene.dart';
import 'scene_widget.dart';

class StagerApp extends StatelessWidget {
  final List<Scene> scenes;

  const StagerApp({super.key, required this.scenes});

  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      builder: (context) => MaterialApp(
        builder: DevicePreview.appBuilder,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        home: Scaffold(
          appBar: AppBar(title: const Text('Scenes')),
          body: ListView.separated(
            itemBuilder: (context, index) => ListTile(
              title: Text(scenes[index].title),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => SceneWidget(scene: scenes[index]),
                  ),
                );
              },
            ),
            separatorBuilder: (_, __) => const Divider(),
            itemCount: scenes.length,
          ),
        ),
      ),
    );
  }
}
