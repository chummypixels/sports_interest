import 'package:flutter/material.dart';

import '../profile/profile_screen.dart';
import '../settings/settings_screen.dart';

//The home screen holds all the screens in the app
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  //All screens currently in the app
  final screens = [
    const ProfileScreen(),
    const Center(
        child: Text(
      'Ouch! No buddies yet',
      style: TextStyle(fontSize: 40),
    )),
    const Center(
        child: Text(
      "It's lonely here",
      style: TextStyle(fontSize: 40),
    )),
    const SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      //set the bottom navigation bar for all the screens
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => setState(() {
                currentIndex = index;
              }),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.sports_kabaddi),
                label: 'Buddies',
                backgroundColor: Colors.green),
            BottomNavigationBarItem(
                icon: Icon(Icons.fitness_center),
                label: 'Discover',
                backgroundColor: Colors.redAccent),
            BottomNavigationBarItem(
                icon: Icon(Icons.app_settings_alt),
                label: 'Settings',
                backgroundColor: Colors.purpleAccent),
          ]),
    );
  }
}
