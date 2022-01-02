// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:trakt_client/src/business_logic/models/models.dart';
import 'package:trakt_client/src/views/ui/widgets/widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(1),
      itemCount: 5,
      itemBuilder: (context, i) {
        return ShowView(Show(i, "amogus"));
      },
    );
  }
}
