// ignore_for_file: non_constant_identifier_names

/* 
This file contains useful methods that interact with the trakt api.
*/

// HTTP requests.
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

/// Redirects the user to the authentication page.
/// The user must, then, login to their account and proceed with
/// the authentication process.
void redirect_user(String clientID) async {
  final url =
      "https://api.trakt.tv/oauth/authorize?response_type=code&client_id=$clientID&redirect_uri=urn:ietf:wg:oauth:2.0:oob&state=%20";

  if (!await launch(url)) {
    throw "Something went wrong lol.";
  }
}

///
/// Retrieves access_token and refresh_token from the respective trakt api endpoint.
/// grant_type can either be authorization_code or refresh_token
///
Future<dynamic> retrieveToken(
    String clientID, String clientSecret, String pin, String grant_type,
    [String refreshToken = ""]) async {
  var url =
      "https://api.trakt.tv/oauth/token?code=$pin&client_id=$clientID&client_secret=$clientSecret&redirect_uri=urn:ietf:wg:oauth:2.0:oob&grant_type=$grant_type";

  var client = HttpClient();
  dynamic r_json;

  try {
    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.add('Content-Type', 'application/json');
    HttpClientResponse response = await request.close();

    // Converts the response into a json object that can be used to retrieve access_token.
    r_json = json.decode((await response.transform(utf8.decoder).join()));
  } finally {
    client.close();
  }

  // lol will refactor this later.
  return r_json;
}

///
/// Returns a new access token and refresh token, calling the respective api endpoint using refresh_token.
///
Future<dynamic> refreshToken(
    String clientID, String clientSecret, String refreshToken) async {
  final url =
      "https://api.trakt.tv/oauth/token?grant_type=refresh_token&client_id=$clientID&refresh_token=$refreshToken&client_secret=$clientSecret&redirect_uri=urn:ietf:wg:oauth:2.0:oob";

  var client = HttpClient();
  dynamic r_json = "";

  try {
    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.add('Content-Type', 'application/json');
    HttpClientResponse response = await request.close();

    // Converts the response into a json object that can be used to retrieve access_token.
    r_json = json.decode((await response.transform(utf8.decoder).join()));
  } finally {
    client.close();
  }

  return r_json;
}
