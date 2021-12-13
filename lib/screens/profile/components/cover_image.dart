import 'package:flutter/material.dart';

const double coverHeight = 280;
Widget buildCoverImage() => Container(
      color: Colors.grey,
      child: Image.network(
        'https://cdn.pixabay.com/photo/2017/05/25/15/08/jogging-2343558_960_720.jpg',
        width: double.infinity,
        height: coverHeight,
        fit: BoxFit.cover,
      ),
    );
