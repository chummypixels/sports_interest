import 'dart:async';

import 'package:flutter/material.dart';

import 'bottomText.dart';

// Onboarding slides class
class Inviter extends StatefulWidget {
  const Inviter({Key? key, required this.getStartedPressed}) : super(key: key);

  final VoidCallback getStartedPressed;

  @override
  _InviterState createState() => _InviterState();
}

class _InviterState extends State<Inviter> {
  final List<String> textOpeners = [
    'HI',
    'WELCOME',
    'TO',
    'ANTIQUE',
    'HAVE, \r\nA\r\nFUN\r\nEXPERIENCE'
  ];

  int index = 1;
  bool showStartCard = false;

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        if (index == 5) {
          timer.cancel();
          setState(() {
            showStartCard = true;
          });
        } else {
          index++;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      switchInCurve: Curves.fastOutSlowIn,
      transitionBuilder: (widget, animation) {
        final zoomAnimation = Tween(begin: 1.0, end: 1.3).animate(animation);
        final fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animation,
            curve: const Interval(0.0, 0.2, curve: Curves.ease),
          ),
        );
        return FadeTransition(
          opacity: fadeAnimation,
          child: ScaleTransition(
            scale: zoomAnimation,
            child: widget,
          ),
        );
      },
      duration: const Duration(milliseconds: 2000),
      child: Container(
        child: Stack(
          children: [
            Center(
              child: Text(textOpeners[index - 1],
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w900)),
            ),
            if (index == 5)
              AnimatedOpacity(
                opacity: showStartCard ? 1 : 0,
                duration: const Duration(milliseconds: 400),
                child: Align(
                  child: Padding(
                    padding: EdgeInsets.all(80.0).copyWith(bottom: 120),
                    child: BottomText(
                      getStarted: widget.getStartedPressed,
                    ),
                  ),
                  alignment: Alignment.bottomCenter,
                ),
              ),
          ],
        ),
        key: ValueKey<int>(index),
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
            image: DecorationImage(
                //fit: BoxFit.cover,
                image: AssetImage('assets/slides/slide${index}.jpg'))),
      ),
    );
  }
}
