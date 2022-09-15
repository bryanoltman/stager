import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stager/stager.dart';
import 'package:stager_example/pages/posts_list/posts_list_page_scenes.dart';

void main() {
  testWidgets('shows a loading state', (WidgetTester tester) async {
    final Scene scene = LoadingScene();
    await scene.setUp();
    await tester.pumpWidget(scene.build());
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows an error state', (WidgetTester tester) async {
    final Scene scene = ErrorScene();
    await scene.setUp();
    await tester.pumpWidget(scene.build());
    await tester.pump();
    expect(find.text('Error'), findsOneWidget);
  });

  // #docregion EmptySceneTest
  testWidgets('shows an empty state', (WidgetTester tester) async {
    final Scene scene = EmptyListScene();
    await scene.setUp();
    await tester.pumpWidget(scene.build());
    await tester.pump();
    expect(find.text('No posts'), findsOneWidget);
  });
  // #enddocregion EmptySceneTest

  testWidgets('shows posts', (WidgetTester tester) async {
    final Scene scene = WithPostsScene();
    await scene.setUp();
    await tester.pumpWidget(scene.build());
    await tester.pump();
    expect(find.text('Post 1'), findsOneWidget);
  });
}
