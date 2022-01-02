import 'package:flutter/material.dart';
import 'package:trakt_client/src/business_logic/models/models.dart' as models;

class ShowView extends StatelessWidget {
  final models.Show show;

  const ShowView(this.show);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Image(
      image: Image.network(show.posterURL).image,
      width: 64,
      height: 64,
    ));
  }
}
