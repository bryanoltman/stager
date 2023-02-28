import 'package:flutter/widgets.dart';

import 'basic_environment_state.dart';

/// Values used to render a [Scene].
/// TODO improve docs
class EnvironmentState extends ChangeNotifier {
  BasicEnvironmentState _basicState = BasicEnvironmentState.defaultState;

  /// TODO
  BasicEnvironmentState get basicState => _basicState;

  /// TODO
  set basicState(BasicEnvironmentState newValue) {
    _basicState = newValue;
    notifyListeners();
  }

  /// Stores current named environment state values.
  Map<String, dynamic> _stateMap = <String, dynamic>{};

  /// Stores default named environment state values.
  final Map<String, dynamic> _stateMapDefaults = <String, dynamic>{};

  /// Sets a default
  void setDefault({required String key, required dynamic value}) {
    _stateMapDefaults[key] = value;

    if (!_stateMap.containsKey(key)) {
      set(key: key, value: value);
    }
  }

  /// Returns the value corresponding to [key] if it exists.
  T? get<T>({required String key}) => _stateMap[key];

  /// Updates the environment value corresponding to [key].
  ///
  /// If no default has been set for this [key], [value] will be used as the
  /// default.
  void set({required String key, required dynamic value}) {
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
    _basicState = BasicEnvironmentState.defaultState;
    _stateMap = Map<String, dynamic>.from(_stateMapDefaults);

    notifyListeners();
  }
}
