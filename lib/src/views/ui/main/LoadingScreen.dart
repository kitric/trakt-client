// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    SharedPreferences.getInstance().then((value) => {
          AuthIfNeeded().then((value) => {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => value))
              }),
        });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              padding: const EdgeInsets.only(
                left: 50,
                right: 50,
              ),
              child: Column(
                children: <Widget>[
                  Image(
                    image: Image.network(
                            "https://res.cloudinary.com/crxssed/image/upload/v1640793463/loading.gif")
                        .image,
                    width: 100,
                    height: 100,
                  ),
                ],
              ),
            ),
            const Text("Loading....")
          ],
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

      SharedPreferences pref = await SharedPreferences.getInstance();

      // Retrieves the cached user data.
      // If it doesn't exist, retrieve it from the trakt api.
      String? userData = pref.getString("user_data");
      if (userData == null) {
        await trakt_api.retrieveUserInfo(accessToken, clientID);

        // TODO: Implement daily check function.
      } else {
        dynamic json = jsonDecode(userData);

        trakt_api.TraktUserInfo.userAbout = json["userAbout"];
        trakt_api.TraktUserInfo.userAvatar = json["userAvatar"];
        trakt_api.TraktUserInfo.userSlug = json["userSlug"];
      }

      page = const HomePage(title: "Trakt Client - Home Page");

      // WORKS.
      var test = await trakt_api.retrieveWatched("shows", clientID);
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
