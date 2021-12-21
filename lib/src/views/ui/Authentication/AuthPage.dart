// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'TokenPage.dart';
import 'package:trakt_client/src/business_logic/models/api_services/trakt_api.dart'
    as api_trakt;

import 'package:trakt_client/src/business_logic/models/utils.dart' as utils;

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
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
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "YOU'RE NOT AUTHENTICATED!",
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
                    /*TextField(
                      decoration: const InputDecoration(
                        labelText: "Client ID",
                      ),
                      maxLines: 1,
                      controller: controller,
                    ),*/
                    OutlinedButton(
                        onPressed: handleClick,
                        child: const Text("Authenticate")),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  void handleClick() {
    api_trakt.redirect_user(utils.RetrieveFromINI("CLIENT_ID"));

    // Opens TokenPage.dart.
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const TokenPage(title: "Trakt Client - Token Page")));
  }
}
