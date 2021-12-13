import 'package:flutter/material.dart';

import 'cover_image.dart';
import 'profile_image.dart';

class BuildTop extends StatelessWidget {
  const BuildTop({
    Key? key,
    required this.top,
  }) : super(key: key);

  final double top;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
            margin: const EdgeInsets.only(bottom: 72),
            child: buildCoverImage()),
        Positioned(top: top, child: buildProfileImage()),
      ],
    );
  }
}
