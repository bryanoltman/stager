import 'package:flutter/material.dart';

/// A [MaterialApp] that inherits its [MediaQuery] and applies the
/// [platform] from its ancestors to default Material dark and light themes.
///
/// This class makes it easier to write Scenes that interact well with the
/// environment manipulation feature provided by [StagerApp]. This class is not
/// required to use Stager, but you will need to ensure that you are properly
/// consuming the [MediaQuery] and [ThemeData.platform] for the environment
/// manipulation feature to work properly.
class EnvironmentAwareApp extends StatelessWidget {
  /// Creates an [EnvironmentAwareApp] with the provided [home].
  const EnvironmentAwareApp({
    super.key,
    required this.home,
    this.localizationsDelegates,
  });

  /// The widget wrapped by this app.
  final Widget home;

  /// Optional list of [LocalizationsDelegate]s, forwarded to the wrapped
  /// [MaterialApp].
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      theme: ThemeData.light().copyWith(platform: Theme.of(context).platform),
      darkTheme:
          ThemeData.dark().copyWith(platform: Theme.of(context).platform),
      home: home,
      localizationsDelegates: localizationsDelegates,
    );
  }
}
