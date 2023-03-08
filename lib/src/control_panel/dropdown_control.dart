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

/// An [EnvironmentControlPanel] widget that allows the user to choose from one
/// of several options.
class DropdownControl<T> extends StatelessWidget {
  /// An [EnvironmentControlPanel] widget that allows the user to choose from one
  /// of several options.
  const DropdownControl({
    super.key,
    required this.title,
    required this.value,
    required this.items,
    required this.onChanged,
    this.itemTitleBuilder,
  });

  /// The name of this config option.
  final Widget title;

  /// The currently selected item.
  final T value;

  /// A list of all available items.
  final List<T> items;

  /// Called when a [value] is changed.
  final void Function(T?) onChanged;

  /// Used to customize the text of [items] in the drop down. Use this when
  /// overriding [T.toString()] is not possible or not desirable.
  final String Function(T)? itemTitleBuilder;

  String _titleForItem(T? item) {
    if (item == null) {
      return '';
    }

    if (itemTitleBuilder == null) {
      return item.toString();
    }

    return itemTitleBuilder!(item);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: EnvironmentControlPanel.labelWidth,
          child: title,
        ),
        const SizedBox(width: 8),
        DropdownButton<T>(
          value: value,
          items: items
              .map(
                (T? e) => DropdownMenuItem<T>(
                  value: e,
                  child: Text(_titleForItem(e)),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
