// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:trakt_client/src/business_logic/models/api_services/trakt_api.dart'
    as api_trakt;

import 'package:trakt_client/src/business_logic/utils/secrets.dart' as sec;

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
            const Text(
              "AUTHENTICATION",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Iosevka"),
            ),
            Container(
                // Put a widget inside a container to set margin.
                margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.only(
                  left: 50,
                  right: 50,
                ),
                child: Column(
                  children: <Widget>[
                    /*const TextField(
                      decoration: InputDecoration(
                        labelText: "Client Secret",
                      ),
                      maxLines: 1,
                    ),*/
                    TextField(
                      decoration: const InputDecoration(
                        labelText: "PIN (after authenticating)",
                      ),
                      maxLines: 1,
                      controller: pinController,
                    ),
                    OutlinedButton(
                      onPressed: handleClick,
                      child: const Text("Get Token."),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  void handleClick() => api_trakt.retrieveToken(
      sec.clientID, sec.clientSecret, pinController.text);
}
