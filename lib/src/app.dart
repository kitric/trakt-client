import 'package:flutter/material.dart';
import 'package:trakt_client/src/views/ui/main/LoadingScreen.dart';

class TraktClient extends StatelessWidget {
  const TraktClient({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // If ACCESS_TOKEN exists, then there's no need to authenticate; there's only need to refresh the token.
    // Widget? page = AuthIfNeeded();
    Widget? page = const LoadingScreen(title: "Loading!");

    return MaterialApp(
      title: 'Trakt Client - Authentication',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.red
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.red
      ),
      themeMode: ThemeMode.system,
      /*
      This is, of course, not the home page.
      Later, we must figure out how to prevent the app from opening
        this page after the user has already completed the authentication
        process.
      */
      home: page,
    );
  }
}
