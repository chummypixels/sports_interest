import 'package:flutter/material.dart';
import 'package:flutter_sports_interest/screens/home/home_screen.dart';
import 'package:flutter_sports_interest/screens/login/login_screen.dart';
import 'package:flutter_sports_interest/screens/onboarding/onboarding.dart';
import 'package:flutter_sports_interest/services/auth_service.dart';
import 'package:provider/provider.dart';

import 'models/user_model.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          return user == null ? const LoginScreen() : const OnBoardingScreen();
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
