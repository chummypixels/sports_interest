import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sports_interest/screens/login/login_screen.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({Key? key}) : super(key: key);

  TextEditingController _resetPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot password'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Reset Page',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _resetPasswordController,
              decoration: InputDecoration(
                labelText: 'Enter Your Email',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                //Let's call the firebase method for resetting the password
                await FirebaseAuth.instance
                    .sendPasswordResetEmail(
                        email: _resetPasswordController.text)
                    //after the reset password method, we take the user back to the LoginScreen
                    //to sign in with the newly generated password
                    .then(
                      (value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      ),
                    );
              },
              child: const Text('Reset Password')),
        ],
      ),
    );
  }
}
