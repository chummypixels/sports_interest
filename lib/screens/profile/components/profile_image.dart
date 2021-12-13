import 'package:flutter/material.dart';

const double profileHeight = 144;

Widget buildProfileImage() => CircleAvatar(
      radius: profileHeight / 2,
      backgroundColor: Colors.grey.shade800,
      backgroundImage: NetworkImage(
        'https://cdn.pixabay.com/photo/2016/06/06/17/05/woman-1439909_960_720.jpg',
      ),
    );
