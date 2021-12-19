// ignore_for_file: non_constant_identifier_names

/* 
Probably will end up renaming this file later.
*/

// HTTP requests.
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

/* Redirects the user to the authentication page.
 The user must, then, login to their account and proceed with
 the authentication process.*/
void redirect_user(String clientID) async {
  final url =
      "https://api.trakt.tv/oauth/authorize?response_type=code&client_id=$clientID&redirect_uri=urn:ietf:wg:oauth:2.0:oob&state=%20";

  if (!await launch(url)) {
    throw "Something went wrong lol.";
  }
}

Future<String> retrieveToken(
    String clientID, String clientSecret, String pin) async {
  final url =
      "https://api.trakt.tv/oauth/token?code=$pin&client_id=$clientID&client_secret=$clientSecret&redirect_uri=urn:ietf:wg:oauth:2.0:oob&grant_type=authorization_code";

  var client = HttpClient();

  try {
    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.add('Content-Type', 'application/json');

    HttpClientResponse response = await request.close();

    print(json.decode((await response.transform(utf8.decoder).join())));
  } finally {
    client.close();
  }

  return "";
}
