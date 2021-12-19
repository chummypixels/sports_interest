import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sports_interest/screens/login/edit_number.dart';
import 'package:flutter_sports_interest/screens/login/verify_number.dart';
import 'package:flutter_sports_interest/screens/profile/profile_screen.dart';
import 'package:provider/provider.dart';
import 'screens/home/home_screen.dart';
import 'screens/login/login_screen.dart';
import 'screens/onboarding/onboarding.dart';
import 'screens/register/register_screen.dart';
import 'screens/settings/settings_screen.dart';
import 'services/auth_service.dart';
import 'wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //home: const OnBoardingScreen()
        initialRoute: '/',
        routes: {
          '/': (context) => const OnBoardingScreen(),
          '/home': (context) => const HomeScreen(),
          '/register': (context) => const RegisterScreen(),
          '/profile': (context) => const ProfileScreen(),
        },
      ),
    );
  }
}
