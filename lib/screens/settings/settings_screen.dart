import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sports_interest/screens/forgot_password/forgot_password_scree.dart';
import 'package:flutter_sports_interest/models/user_model.dart';
import 'package:flutter_sports_interest/screens/login/login_screen.dart';
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController _currentEmailController = TextEditingController();
  TextEditingController _newEmailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Account Settings',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            buildAccountOption(context, 'Change Password', onTappedOne),
            const Divider(
              height: 20,
              thickness: 1,
            ),
            const SizedBox(
              height: 30,
            ),
            buildAccountOption(context, 'Update Email', onTapped),
            const Divider(
              height: 20,
              thickness: 1,
            ),
            const SizedBox(
              height: 30,
            ),
            buildAccountOption(context, 'Update Username', onTapped),
            const Divider(
              height: 20,
              thickness: 1,
            ),
            ElevatedButton(
              onPressed: () {
                _userEditBottomSheet(context);
              },
              child: Text('Edit User'),
            ),
            const SizedBox(
              height: 90,
            ),
            Center(
              child: OutlinedButton(
                  onPressed: () async {
                    await authService.signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false);
                  },
                  style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: const Text('SIGN OUT')),
            )
          ],
        ),
      ),
    );
  }

  void _userEditBottomSheet(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * .60,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 15.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text('Update Profile'),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.cancel),
                          color: Colors.orange,
                          iconSize: 25,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 15.0),
                            child: Column(
                              children: [
                                TextField(
                                  controller: _currentEmailController,
                                  decoration: InputDecoration(
                                      helperText: 'Current Email'),
                                ),
                                TextField(
                                  controller: _newEmailController,
                                  decoration:
                                      InputDecoration(helperText: 'New Email'),
                                ),
                                TextField(
                                  controller: _passwordController,
                                  decoration:
                                      InputDecoration(helperText: 'Password'),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            authService.updateEmail(
                                oldEmail: _currentEmailController.text,
                                newEmail: _newEmailController.text,
                                password: _passwordController.text);
                            Navigator.of(context).pop();
                          },
                          child: Text('Save'),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  onTappedOne() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ForgotPassword()));
  }

  onTapped() {}

  // Future updateEmail(
  //     {required String oldEmail,
  //       required String newEmail,
  //       required String password}) async {
  //   try {
  //     var user = await _firebaseAuth
  //         .signInWithEmailAndPassword(email: oldEmail, password: password)
  //         .then((value) {
  //       value.user!.updateEmail(newEmail);
  //     });
  //   } catch (e) {
  //     return e;
  //   }
  // }

  GestureDetector buildAccountOption(
      BuildContext context, String title, VoidCallback onTapped) {
    return GestureDetector(
      onTap: onTapped,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600]),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
