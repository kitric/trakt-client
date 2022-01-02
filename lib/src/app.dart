import 'package:flutter/material.dart';
import 'package:trakt_client/src/views/ui/main/LoadingScreen.dart';

class TraktClient extends StatelessWidget {
  const TraktClient({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget? page = const LoadingScreen(title: "Loading!");

    return MaterialApp(
      title: 'Trakt Client - Authentication',
      theme: ThemeData(brightness: Brightness.light, primarySwatch: Colors.red),
      darkTheme:
          ThemeData(brightness: Brightness.dark, primarySwatch: Colors.red),
      themeMode: ThemeMode.system,
      home: page,
    );
  }
}
