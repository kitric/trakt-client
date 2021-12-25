import 'package:flutter/material.dart';
import 'package:trakt_client/src/views/ui/Authentication/AuthPage.dart';
import 'package:trakt_client/src/business_logic/models/utils.dart' as utils;
import 'package:trakt_client/src/views/ui/main/HomePage.dart';
import 'package:trakt_client/src/business_logic/models/api_services/trakt_api.dart'
    as api_trakt;

class TraktClient extends StatelessWidget {
  const TraktClient({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // If ACCESS_TOKEN exists, then there's no need to authenticate; there's only need to refresh the token.
    Widget? page = AuthIfNeeded();

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

///
/// Checks whether the user needs to go through the authentication process or not
/// if not, access_token and refresh_token are refreshed.
///
Widget? AuthIfNeeded() {
  Widget? page;

  String accessToken = utils.RetrieveFromINI("ACCESS_TOKEN");
  String clientID = utils.RetrieveFromINI("CLIENT_ID");

  if (accessToken == "") {
    page = const AuthPage(title: "Trakt Client - Authentication");
  } else {
    // Also refreshes token.
    page = const HomePage(title: "Trakt Client - Home Page");

    // After retrieving the access_token and refresh_token, write them to the .ini file.
    api_trakt
        .refreshToken(
            clientID,
            utils.RetrieveFromINI("CLIENT_SECRET"),
            utils.RetrieveFromINI("REFRESH_TOKEN"))
        .then((value) => {
              accessToken = value['access_token'],
              utils.WriteToINI("ACCESS_TOKEN", accessToken),
              utils.WriteToINI("REFRESH_TOKEN", value['refresh_token'])
            });
  }

  // Retreives the users information
  api_trakt.retrieveUserInfo(accessToken, clientID);

  print("1." + api_trakt.TraktUserInfo.userSlug);
  print("1." + api_trakt.TraktUserInfo.userAbout);
  print("1." + api_trakt.TraktUserInfo.userAvatar);

  return page;
}
