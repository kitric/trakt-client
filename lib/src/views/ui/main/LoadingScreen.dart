// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:trakt_client/src/business_logic/models/api_services/trakt_api.dart'
    as trakt_api;
import 'package:trakt_client/src/views/ui/Authentication/AuthPage.dart';
import 'package:trakt_client/src/business_logic/models/utils.dart' as utils;

import 'HomePage.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    AuthIfNeeded().then((value) => {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => value))
        });

    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itselfR and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[Text("Loading....")],
        ),
      ),
    );
  }

  ///
  /// Checks whether the user needs to go through the authentication process or not
  /// if not, access_token and refresh_token are refreshed.
  ///
  Future<Widget> AuthIfNeeded() async {
    Widget? page;

    String accessToken = utils.RetrieveFromINI("ACCESS_TOKEN");
    String clientID = utils.RetrieveFromINI("CLIENT_ID");

    if (accessToken == "") {
      page = const AuthPage(title: "Trakt Client - Authentication");
    } else {
      // Also refreshes token.
      await refreshToken(clientID, accessToken);

      accessToken = utils.RetrieveFromINI("ACCESS_TOKEN");
      clientID = utils.RetrieveFromINI("CLIENT_ID");
      await trakt_api.retrieveUserInfo(accessToken, clientID);

      page = const HomePage(title: "Trakt Client - Home Page");
    }

    return page;
  }

  Future refreshToken(String clientID, String accessToken) async {
    // After retrieving the access_token and refresh_token, write them to the .ini file.
    await trakt_api
        .refreshToken(clientID, utils.RetrieveFromINI("CLIENT_SECRET"),
            utils.RetrieveFromINI("REFRESH_TOKEN"))
        .then((value) => {
              accessToken = value['access_token'],
              utils.WriteToINI("ACCESS_TOKEN", accessToken),
              utils.WriteToINI("REFRESH_TOKEN", value['refresh_token'])
            });
  }
}
