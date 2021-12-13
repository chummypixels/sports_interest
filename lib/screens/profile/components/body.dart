import 'package:flutter/material.dart';
import 'package:flutter_sports_interest/screens/profile/components/cover_image.dart';

import 'build_content.dart';
import 'profile_image.dart';
import 'top.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    const top = coverHeight - profileHeight / 2;

    return Scaffold(
        body: ListView(
      children: <Widget>[
        const BuildTop(top: top),
        const SizedBox(
          height: 30,
        ),
        BuildContent(),
      ],
    ));
  }
}
