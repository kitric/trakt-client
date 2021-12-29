// ignore_for_file: non_constant_identifier_names

/* 
This file contains useful methods that interact with the trakt api.
*/

//TODO: MaKe the code less repetitive.

// HTTP requests.
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

///
/// Contains useful info about the user, such as their slug.
///
abstract class TraktUserInfo {
  static String userSlug = "";
  static String userAbout = "";
  static String userAvatar = "";
}

/// Redirects the user to the authentication page.
/// The user must, then, login to their account and proceed with
/// the authentication process.
///
void redirect_user(String clientID) async {
  final url =
      "https://api.trakt.tv/oauth/authorize?response_type=code&client_id=$clientID&redirect_uri=urn:ietf:wg:oauth:2.0:oob&state=%20";

  if (!await launch(url)) {
    throw "Something went wrong.";
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

/// THIS METHOD SHOULD ONLY BE CALLED ONCE.
/// Retrieves useful information about the user from the trakt API.
Future retrieveUserInfo(String accessToken, String clientID) async {
  const url = "https://api.trakt.tv/users/settings";
  var client = HttpClient();

  try {
    HttpClientRequest request = await client.getUrl(Uri.parse(url));

    // Adds necessary headers.
    request.headers.add('Content-Type', 'application/json');
    request.headers.add('Authorization', 'Bearer $accessToken');
    request.headers.add('trakt-api-key', clientID);
    request.headers.add('trakt-api-version', 2);

    var response = await request.close();

    // Converts the response into a json object that can be used to retrieve user_slug.
    final r_json = json.decode((await response.transform(utf8.decoder).join()));
    final userAbout = r_json['user']['about'];
    final userSlug = r_json['user']['ids']['slug'];
    final userAvatar = r_json['user']['images']['avatar']['full'];
    TraktUserInfo.userSlug = userSlug;
    TraktUserInfo.userAbout = userAbout;
    TraktUserInfo.userAvatar = userAvatar;
    String jsonString = "{\"userSlug\": \"$userSlug\", \"userAbout\": \"$userAbout\", \"userAvatar\": \"$userAvatar\"}";
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('user_data', jsonString);
    print(pref.getString('user_data'));
  } finally {
    client.close();
  }
}
