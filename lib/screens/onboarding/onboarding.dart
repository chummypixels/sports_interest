import 'package:flutter/material.dart';
import 'package:flutter_sports_interest/screens/onboarding/components/body.dart';
import 'package:flutter_sports_interest/screens/onboarding/components/inviter.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}
