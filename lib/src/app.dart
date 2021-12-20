import 'package:flutter/material.dart';
import 'package:trakt_client/src/views/ui/Authentication/AuthPage.dart';
import 'package:trakt_client/src/business_logic/models/utils.dart' as utils;
import 'package:trakt_client/src/views/ui/main/HomePage.dart';

class TraktClient extends StatelessWidget {
  const TraktClient({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // If ACCESS_TOKEN exists, then there's no need to authenticate.
    Widget? page = utils.RetrieveFromINI("ACCESS_TOKEN") == ""
        ? const AuthPage(title: 'Trakt Client - Authentication')
        : const HomePage(title: 'Trakt Client - Home Page');

    return MaterialApp(
      title: 'Trakt Client - Authentication',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.amber,
      ),
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
