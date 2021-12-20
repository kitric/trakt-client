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

/* 
Retrieves access_token and refresh_token from the respective trakt api endpoint.
*/
Future<String> retrieveToken(
    String clientID, String clientSecret, String pin) async {
  final url =
      "https://api.trakt.tv/oauth/token?code=$pin&client_id=$clientID&client_secret=$clientSecret&redirect_uri=urn:ietf:wg:oauth:2.0:oob&grant_type=authorization_code";

  var client = HttpClient();
  String access_token = "";

  try {
    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.add('Content-Type', 'application/json');
    HttpClientResponse response = await request.close();

    // Converts the response into a json object that can be used to retrieve access_token.
    final r_json = json.decode((await response.transform(utf8.decoder).join()));
    access_token = r_json['access_token'];
  } finally {
    client.close();
  }

  // lol will refactor this later.
  return access_token;
}

Future<String> refreshToken(String accessToken, String clientID,
    String clientSecret, String refreshToken) async {
  final url =
      "https://api.trakt.tv/oauth/token?grant_type=refresh_token&client_id=$clientID&refresh_token=$refreshToken&client_secret=$clientSecret&redirect_uri=urn:ietf:wg:oauth:2.0:oob";

  var client = HttpClient();
  String newToken = "";

  try {
    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.add('Content-Type', 'application/json');
    HttpClientResponse response = await request.close();

    // Converts the response into a json object that can be used to retrieve access_token.
    final r_json = json.decode((await response.transform(utf8.decoder).join()));
    newToken = r_json['access_token'];
  } finally {
    client.close();
  }

  return newToken;
}
