import 'package:flutter/widgets.dart';

/// Values used to control the display of a [Scene].
///
///
class EnvironmentState extends ChangeNotifier {
  /// Creates an [EnvironmentState] with default values for dark mode, text
  /// scale, etc.
  EnvironmentState() {
    _stateMapDefaults = Map<String, dynamic>.from(builtInStateDefaults);
    _stateMap = Map<String, dynamic>.from(_stateMapDefaults);
  }

  /// The number of font pixels for each logical pixel.
  static const String textScaleKey = 'EnvironmentState.textScale';

  /// Whether to use [Brightness.dark].
  static const String isDarkModeKey = 'EnvironmentState.isDarkMode';

  /// Whether text is drawn with a bold font weight.
  static const String isTextBoldKey = 'EnvironmentState.isTextBold';

  /// Whether a [SemanticsDebugger] is shown over the UI.
  ///
  /// NOTE: this may not behave as expected until
  /// https://github.com/flutter/flutter/issues/120615 is fixed.
  static const String showSemanticsKey = 'EnvironmentState.showSemantics';

  /// The platform that user interaction should adapt to target.
  ///
  /// If null, defaults to the current platform.
  static const String targetPlatformKey = 'EnvironmentState.targetPlatform';

  /// A custom vertical size value.
  ///
  /// If null, the current window/screen height will be used.
  static const String heightOverrideKey = 'EnvironmentState.heightOverride';

  /// A custom horizontal size value.
  ///
  /// If null, the current window/screen height will be used.
  static const String widthOverrideKey = 'EnvironmentState.widthOverride';

  /// Default values for built-in state variables.
  static const Map<String, dynamic> builtInStateDefaults = <String, dynamic>{
    textScaleKey: 1.0,
    isDarkModeKey: false,
    isTextBoldKey: false,
    showSemanticsKey: false,
    targetPlatformKey: null,
    heightOverrideKey: null,
    widthOverrideKey: null,
  };

  /// Stores current named environment state values.
  late Map<String, dynamic> _stateMap;

  /// Stores default named environment state values.
  late final Map<String, dynamic> _stateMapDefaults;

  /// Sets a default
  void setDefault(String key, dynamic value) {
    _stateMapDefaults[key] = value;

    if (!_stateMap.containsKey(key)) {
      _stateMap[key] = value;
    }
  }

  /// Returns the value corresponding to [key] if it exists.
  T? get<T>(String key) => _stateMap[key];

  /// Updates the environment value corresponding to [key].
  ///
  /// If no default has been set for this [key], [value] will be used as the
  /// default.
  void set(String key, dynamic value) {
    // If this key is new, use [value] as the default.
    if (!_stateMap.containsKey(key)) {
      _stateMapDefaults[key] = value;
    }

    _stateMap[key] = value;

    notifyListeners();
  }

  /// Resets all environment variables to their default state and notifies
  /// listeners.
  void reset() {
    _stateMap = Map<String, dynamic>.from(_stateMapDefaults);

    notifyListeners();
  }
}
