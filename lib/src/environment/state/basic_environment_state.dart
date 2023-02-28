import 'package:built_value/built_value.dart';
import 'package:flutter/foundation.dart';

part 'basic_environment_state.g.dart';

/// Environment values that are included with and manipulatable by the
/// [EnvironmentControlPanel].
///
/// TODO: should this class exist? Would it be better to just roll these into
/// the state map in EnvironmentState?
abstract class BasicEnvironmentState
    implements Built<BasicEnvironmentState, BasicEnvironmentStateBuilder> {
  /// A [BasicEnvironmentState] with default values.
  static BasicEnvironmentState defaultState = BasicEnvironmentState(
    isDarkMode: false,
    isTextBold: false,
    showSemantics: false,
    textScale: 1.0,
  );

  /// The number of font pixels for each logical pixel.
  double get textScale;

  /// Whether to use [Brightness.dark].
  bool get isDarkMode;

  /// Whether text is drawn with a bold font weight.
  bool get isTextBold;

  /// Whether a [SemanticsDebugger] is shown over the UI.
  ///
  /// NOTE: this may not behave as expected until
  /// https://github.com/flutter/flutter/issues/120615 is fixed.
  bool get showSemantics;

  /// The platform that user interaction should adapt to target.
  ///
  /// If null, defaults to the current platform.
  TargetPlatform? get targetPlatform;

  /// A custom vertical size value.
  ///
  /// If null, the current window/screen height will be used.
  int? get heightOverride;

  /// A custom horizontal size value.
  ///
  /// If null, the current window/screen height will be used.
  int? get widthOverride;

  // ignore: sort_constructors_first, public_member_api_docs
  factory BasicEnvironmentState({
    required double textScale,
    required bool isDarkMode,
    required bool isTextBold,
    required bool showSemantics,
    TargetPlatform? targetPlatform,
    int? heightOverride,
    int? widthOverride,
  }) = _$BasicEnvironmentState._;

  // ignore: sort_constructors_first
  BasicEnvironmentState._();
}
