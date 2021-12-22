// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:trakt_client/src/business_logic/models/api_services/trakt_api.dart'
    as api_trakt;

import 'package:trakt_client/src/business_logic/models/utils.dart' as utils;
import 'package:trakt_client/src/views/ui/main/HomePage.dart';

class TokenPage extends StatefulWidget {
  const TokenPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<TokenPage> createState() => _TokenPageState();
}

class _TokenPageState extends State<TokenPage> {
  final TextEditingController pinController = TextEditingController();

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
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
                            "https://trakt.tv/assets/logos/header@2x-d6926a2c93734bee72c5813819668ad494dbbda651457cd17d15d267bc75c657.png")
                        .image,
                    width: 100,
                    height: 100,
                  ),
                ],
              ),
            ),
            const Text(
              "Input your PIN",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Century Gothic"),
            ),
            Container(
                // Put a widget inside a container to set margin.
                margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.only(
                  left: 500,
                  right: 500,
                ),
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: "PIN",
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 237, 28, 36)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 237, 28, 36), width: 2.0),
                    ),
                  ),
                  maxLines: 1,
                  controller: pinController,
                )),
            Container(
              margin: const EdgeInsets.only(top: 35),
              padding: const EdgeInsets.only(
                left: 50,
                right: 50,
              ),
              child: Column(
                children: <Widget>[
                  OutlinedButton(
                      onPressed: handleClick,
                      child: const Text("Login"),
                      style: OutlinedButton.styleFrom(
                        primary: const Color.fromARGB(255, 255, 255, 255),
                        backgroundColor: const Color.fromARGB(255, 237, 28, 36),
                      )),
                  const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "A webpage should have opened, displaying your one time PIN number.",
                      style: TextStyle(
                          color: Colors.grey, fontFamily: "Century Gothic"),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void handleClick() async {
    final clientID = utils.RetrieveFromINI("CLIENT_ID");
    final clientSecret = utils.RetrieveFromINI("CLIENT_SECRET");

    final response_json = await api_trakt.retrieveToken(
        clientID, clientSecret, pinController.text, "authorization_code");

    // Figure out what to do with the token.
    utils.WriteToINI("ACCESS_TOKEN", response_json['access_token']);
    utils.WriteToINI("REFRESH_TOKEN", response_json['refresh_token']);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const HomePage(title: "Trakt Client - Home Page")));
  }
}
