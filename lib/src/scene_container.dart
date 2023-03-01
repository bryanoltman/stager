import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'environment/controls/boolean_control.dart';
import 'environment/controls/display_size_picker.dart';
import 'environment/controls/dropdown_control.dart';
import 'environment/controls/stepper_control.dart';
import 'environment/environment_control_panel.dart';
import 'environment/state/environment_state.dart';
import 'scene.dart';

/// Wraps [child] in a MediaQuery whose properties (such as textScale and
/// brightness) are editable using an on-screen widget.
///
/// The environment editing widget can be toggled using a two-finger long press.
class SceneContainer extends StatefulWidget {
  /// Creates a [SceneContainer].
  const SceneContainer({
    super.key,
    required this.scene,
  });

  /// The [Scene] being displayed.
  final Scene scene;

  @override
  State<SceneContainer> createState() => _SceneContainerState();
}

class _SceneContainerState extends State<SceneContainer> {
  static const Duration _panelAnimationDuration = Duration(milliseconds: 250);
  static const double _panelDividerWidth = 1;

  Key _containerKey = UniqueKey();

  bool _isControlPanelExpanded = false;

  @override
  void initState() {
    super.initState();

    final EnvironmentState environmentState = context.read<EnvironmentState>();

    for (final EnvironmentControl<dynamic> control
        in widget.scene.environmentControls) {
      environmentState.setDefault(control.stateKey, control.defaultValue);
    }

    environmentState.addListener(_rebuildScene);
  }

  @override
  void dispose() {
    if (context.mounted) {
      context.read<EnvironmentState>().removeListener(_rebuildScene);
    }
    super.dispose();
  }

  void _rebuildScene() {
    if (!mounted) {
      return;
    }

    // Create a new UniqueKey to force recreation of StatefulWidgets' states.
    setState(() => _containerKey = UniqueKey());
  }

  void _resetScene() {
    setState(() {
      context.read<EnvironmentState>().reset();
      _rebuildScene();
    });
  }

  double get _panelWidth => min(MediaQuery.of(context).size.width * 0.75, 300);
  bool get isSmallScreen => MediaQuery.of(context).size.width < 600;

  Size get _defaultSceneSize {
    final Size viewportSize = MediaQuery.of(context).size;
    return isSmallScreen
        ? viewportSize
        : Size(
            viewportSize.width - _panelWidth - _panelDividerWidth,
            viewportSize.height,
          );
  }

  double get _sceneHeight {
    final int? heightOverride = context
        .read<EnvironmentState>()
        .get<int>(EnvironmentState.heightOverrideKey);

    if (heightOverride != null) {
      return heightOverride.toDouble();
    } else {
      return MediaQuery.of(context).size.height;
    }
  }

  double get _sceneWidth {
    final int? widthOverride = context
        .read<EnvironmentState>()
        .get<int>(EnvironmentState.widthOverrideKey);
    if (widthOverride != null) {
      return widthOverride.toDouble();
    }

    final double screenWidth = MediaQuery.of(context).size.width;

    if (isSmallScreen) {
      return screenWidth;
    }

    return screenWidth - _panelWidth - _panelDividerWidth;
  }

  Widget _panel() {
    final EnvironmentState environmentState = context.read<EnvironmentState>();

    return SizedBox(
      width: _panelWidth,
      child: EnvironmentControlPanel(
        targetPlatform: environmentState
            .get<TargetPlatform>(EnvironmentState.targetPlatformKey),
        children: <Widget>[
          if (Navigator.of(context).canPop())
            IconButton(
              key: const ValueKey<String>('PopToSceneListButton'),
              onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
              icon: const Icon(Icons.arrow_back),
            ),
          BooleanControl(
            key: const ValueKey<String>(
              'ToggleDarkModeControl',
            ),
            title: const Text('Dark Mode'),
            isOn: environmentState.get<bool>(EnvironmentState.isDarkModeKey)!,
            onChanged: (bool newValue) =>
                environmentState.set(EnvironmentState.isDarkModeKey, newValue),
          ),
          BooleanControl(
            key: const ValueKey<String>(
              'ToggleBoldTextControl',
            ),
            title: const Text('Bold Text'),
            isOn: environmentState.get<bool>(EnvironmentState.isTextBoldKey)!,
            onChanged: (bool newValue) =>
                environmentState.set(EnvironmentState.isTextBoldKey, newValue),
          ),
          BooleanControl(
            key: const ValueKey<String>(
              'ToggleSemanticsOverlayControl',
            ),
            title: const Text('Semantics'),
            isOn:
                environmentState.get<bool>(EnvironmentState.showSemanticsKey)!,
            onChanged: (bool newValue) => environmentState.set(
                EnvironmentState.showSemanticsKey, newValue),
          ),
          StepperControl(
              key: const ValueKey<String>(
                'TextScaleStepperControl',
              ),
              title: const Text('Text Scale'),
              value: environmentState
                  .get<double>(EnvironmentState.textScaleKey)!
                  .toStringAsFixed(1),
              onDecrementPressed: () {
                environmentState.set(
                  EnvironmentState.textScaleKey,
                  environmentState.get<double>(EnvironmentState.textScaleKey)! -
                      0.1,
                );
              },
              onIncrementPressed: () {
                environmentState.set(
                  EnvironmentState.textScaleKey,
                  environmentState.get<double>(EnvironmentState.textScaleKey)! +
                      0.1,
                );
              }),
          DisplaySizePicker(
            defaultSize: _defaultSceneSize,
            didChangeSize: (num? width, num? height) {
              environmentState.set(EnvironmentState.heightOverrideKey, height);
              environmentState.set(EnvironmentState.widthOverrideKey, width);
            },
          ),
          DropdownControl<TargetPlatform>(
            title: const SizedBox(
              width: EnvironmentControlPanel.labelWidth,
              child: Text('Target Platform'),
            ),
            items: TargetPlatform.values,
            onChanged: (TargetPlatform? newValue) => setState(() {
              environmentState.set(
                  EnvironmentState.targetPlatformKey, newValue);
            }),
            value: environmentState
                    .get<TargetPlatform>(EnvironmentState.targetPlatformKey) ??
                Theme.of(context).platform,
            itemTitleBuilder: (TargetPlatform platform) => platform.name,
          ),
          ...widget.scene.environmentControls
              .map((EnvironmentControl<dynamic> control) {
            return control.builder(context, environmentState);
          }),
          const SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              onPressed: _resetScene,
              child: const Text('Reset'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sceneWrapper() {
    final EnvironmentState environmentState = context.read<EnvironmentState>();
    return MediaQuery(
      key: const ValueKey<String>('SceneContainerMediaQuery'),
      data: MediaQuery.of(context).copyWith(
        boldText: environmentState.get<bool>(EnvironmentState.isTextBoldKey),
        textScaleFactor:
            environmentState.get<double>(EnvironmentState.textScaleKey),
        platformBrightness:
            environmentState.get<bool>(EnvironmentState.isDarkModeKey)!
                ? Brightness.dark
                : Brightness.light,
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
            platform: environmentState
                .get<TargetPlatform>(EnvironmentState.targetPlatformKey)),
        child: SizedBox(
          key: _containerKey,
          width: _sceneWidth,
          height: _sceneHeight,
          child: ClipRect(
            child:
                environmentState.get<bool>(EnvironmentState.showSemanticsKey)!
                    ? SemanticsDebugger(child: widget.scene.build(context))
                    : widget.scene.build(context),
          ),
        ),
      ),
    );
  }

  /// A layout for narrower screens that makes the [EnvironmentControlPanel]
  /// collapsible.
  Widget _smallScreenLayout() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        _sceneWrapper(),
        AnimatedContainer(
          padding: EdgeInsets.zero,
          alignment: Alignment.centerLeft,
          transform: Matrix4.translationValues(
            _isControlPanelExpanded ? 0 : -_panelWidth,
            0,
            0,
          ),
          duration: _panelAnimationDuration,
          curve: Curves.easeOutCubic,
          child: SafeArea(
            child: Row(
              children: <Widget>[
                _panel(),
                MaterialButton(
                  key: const ValueKey<String>(
                    'ToggleEnvironmentControlPanelButton',
                  ),
                  color: Colors.white,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(10),
                  onPressed: () {
                    setState(() {
                      _isControlPanelExpanded = !_isControlPanelExpanded;
                    });
                  },
                  child: AnimatedRotation(
                    duration: _panelAnimationDuration,
                    turns: _isControlPanelExpanded ? 0.5 : 0.0,
                    child: const Icon(Icons.arrow_forward),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// A master-detail layout that makes the [EnvironmentControlPanel]
  /// non-collapsible.
  Widget _largeScreenLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SafeArea(
          child: _panel(),
        ),
        const VerticalDivider(width: _panelDividerWidth),
        const Spacer(),
        Center(
          child: _sceneWrapper(),
        ),
        const Spacer(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: isSmallScreen ? _smallScreenLayout() : _largeScreenLayout(),
    );
  }
}
