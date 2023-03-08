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

import 'environment_control_panel.dart';

/// An [EnvironmentControlPanel] widget that allows a user to toggle an
/// arbitrary environment value.
class BooleanControl extends StatelessWidget {
  /// An [EnvironmentControlPanel] widget that allows a user to toggle an
  /// arbitrary environment value.
  const BooleanControl({
    super.key,
    required this.title,
    required this.isOn,
    required this.onChanged,
  });

  /// The name of the value being controlled.
  final Widget title;

  /// Whether the value is toggled on or not.
  final bool isOn;

  /// Called when the [Switch] is toggled.
  final void Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: EnvironmentControlPanel.labelWidth,
          child: title,
        ),
        Switch(
          value: isOn,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
