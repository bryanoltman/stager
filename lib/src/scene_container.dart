import 'package:flutter/material.dart';

import 'multifinger_long_press_gesture.dart';

/// Wraps [child] in a MediaQuery whose properties (such as textScale and
/// brightness) are editable using an on-screen widget.
///
/// The environment editing widget can be toggled using a two-finger long press.
class SceneContainer extends StatefulWidget {
  final Widget child;

  const SceneContainer({super.key, required this.child});

  @override
  State<SceneContainer> createState() => _SceneContainerState();
}

class _SceneContainerState extends State<SceneContainer> {
  bool _showEnvPanel = true;

  double _textScale = 1;
  bool _isDarkMode = false;
  TargetPlatform? _targetPlatform;

  @override
  Widget build(BuildContext context) {
    return MultiTouchLongPressGestureDetector(
      numberOfTouches: 2,
      onGestureDetected: () => setState(() {
        _showEnvPanel = !_showEnvPanel;
      }),
      child: Stack(
        children: [
          MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: _textScale,
              platformBrightness:
                  _isDarkMode ? Brightness.dark : Brightness.light,
            ),
            child: Theme(
              data: Theme.of(context).copyWith(platform: _targetPlatform),
              child: widget.child,
            ),
          ),
          if (_showEnvPanel)
            SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Material(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed:
                              Navigator.of(context, rootNavigator: true).pop,
                          icon: Icon(Icons.arrow_back),
                        ),
                        IconButton(
                          onPressed: () => setState(() {
                            _isDarkMode = !_isDarkMode;
                          }),
                          icon: Icon(Icons.light_mode),
                        ),
                        IconButton(
                          onPressed: () => setState(() {
                            _textScale -= 0.1;
                          }),
                          icon: Icon(Icons.text_decrease),
                        ),
                        IconButton(
                          onPressed: () => setState(() {
                            _textScale += 0.1;
                          }),
                          icon: Icon(Icons.text_increase),
                        ),
                        DropdownButton<TargetPlatform>(
                          items: TargetPlatform.values
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.name),
                                ),
                              )
                              .toList(),
                          onChanged: (newPlatform) => setState(() {
                            _targetPlatform = newPlatform;
                          }),
                          value: _targetPlatform ?? Theme.of(context).platform,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
