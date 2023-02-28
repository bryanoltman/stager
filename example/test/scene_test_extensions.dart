import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stager/stager.dart';

extension Testing on Scene {
  Future<void> setUpAndPump(
    WidgetTester tester, [
    EnvironmentState? environmentState,
  ]) async {
    await this.setUp(environmentState ?? EnvironmentState());

    await tester.pumpWidget(
      Builder(
        builder: (BuildContext context) => build(context),
      ),
    );

    await tester.pump();
  }
}
