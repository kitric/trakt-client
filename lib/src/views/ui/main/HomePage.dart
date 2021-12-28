// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:trakt_client/src/business_logic/models/api_services/trakt_api.dart'
    as trakt_api;

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              /*
              padding: const EdgeInsets.only(
                left: 50,
                right: 50,
              ),*/
              height: 100.0,
              width: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                  image: Image.network(trakt_api.TraktUserInfo.userAvatar).image,
                  fit: BoxFit.cover
                ),
                border: Border.all(color: const Color.fromARGB(255, 237, 28, 36), width: 5)
              ),
            ),
            Text(
              trakt_api.TraktUserInfo.userSlug,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Century Gothic"),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              padding: const EdgeInsets.only(
                left: 350,
                right: 350,
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    trakt_api.TraktUserInfo.userAbout,
                    style: const TextStyle(
                      fontSize: 15,
                      fontFamily: "Century Gothic",
                    ),
                    textAlign: TextAlign.center)
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              padding: const EdgeInsets.only(
                left: 350,
                right: 350,
              ),
              child: Column(
                children: const <Widget>[
                  Text(
                    "TODO: Add a function to get all the items (movies/shows) to load onto the profile page. We can have a separate page for \"Discover\"",
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: "Century Gothic",
                      color: Colors.grey
                    ),
                    textAlign: TextAlign.center)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
