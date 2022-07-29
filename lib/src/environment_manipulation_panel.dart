import 'package:flutter/material.dart';

/// A row of controls used to toggle [Theme] and [MediaQuery] parameters, like
/// [MediaQuery.brightness] and [MediaQuery.textScale].
class EnvironmentManipulationPanel extends StatefulWidget {
  final VoidCallback toggleDarkMode;
  final VoidCallback decrementTextScale;
  final VoidCallback incrementTextScale;
  final void Function(TargetPlatform?) onTargetPlatformChanged;

  final TargetPlatform? targetPlatform;

  const EnvironmentManipulationPanel({
    super.key,
    required this.toggleDarkMode,
    required this.decrementTextScale,
    required this.incrementTextScale,
    required this.onTargetPlatformChanged,
    this.targetPlatform,
  });

  @override
  State<EnvironmentManipulationPanel> createState() =>
      _EnvironmentManipulationPanelState();
}

class _EnvironmentManipulationPanelState
    extends State<EnvironmentManipulationPanel> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            IconButton(
              onPressed: Navigator.of(context, rootNavigator: true).pop,
              icon: Icon(Icons.arrow_back),
            ),
            IconButton(
              onPressed: widget.toggleDarkMode,
              icon: Icon(Icons.light_mode),
            ),
            IconButton(
              onPressed: widget.decrementTextScale,
              icon: Icon(Icons.text_decrease),
            ),
            IconButton(
              onPressed: widget.incrementTextScale,
              icon: Icon(Icons.text_increase),
            ),
            DropdownButton<TargetPlatform>(
              items: TargetPlatform.values
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.name),
                      ))
                  .toList(),
              onChanged: widget.onTargetPlatformChanged,
              value: widget.targetPlatform ?? Theme.of(context).platform,
            ),
          ],
        ),
      ),
    );
  }
}
