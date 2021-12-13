import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sports_interest/screens/forgot_password/forgot_password_scree.dart';
import 'package:flutter_sports_interest/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';
import '../onboarding/onboarding.dart';
import 'edit_number.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //setup the form key
  final _formKey = GlobalKey<FormState>();
  String name = "";

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    final authService = Provider.of<AuthService>(context);
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('Login'),
          centerTitle: true,
        ),
        body: Container(
            padding: EdgeInsets.only(left: 40, right: 40),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: height * 0.04),
                  Text('Just a fun place to be',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 30, color: Colors.blue.shade800)),
                  Text('Welcomed',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 30, color: Colors.blue.shade800)),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Enter your email',
                    ),
                    validator: (value) {
                      final pattern =
                          r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
                      final regExp = RegExp(pattern);

                      if (value!.isEmpty) {
                        return 'Enter an email';
                      } else if (!regExp.hasMatch(value)) {
                        return 'Enter a valid email';
                      } else {
                        return null;
                      }
                    },
                    // validator: (value){
                    //   if(value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)){
                    //     return 'Please enter correct email';
                    //   }else{
                    //     return null;
                    //   }
                    // },
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration:
                        const InputDecoration(labelText: 'Enter your password'),
                    validator: (value) {
                      if (value!.length < 7) {
                        return 'Password must be at least 7 characters long';
                      } else {
                        return null;
                      }
                    },
                    // validator: (value){
                    //   if(value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)){
                    //     return 'Please enter valid password';
                    //   }else{
                    //     return null;
                    //   }
                    // },
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final isValid = _formKey.currentState!.validate();

                          if (isValid) {
                            _formKey.currentState!.save();
                            //Here, we implement the login functionality
                            await authService.signInWithEmailAndPassword(
                                _emailController.text,
                                _passwordController.text);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const OnBoardingScreen()));
                          }
                        },
                        child: const Text('Login'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: const Text('Register'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPassword()));
                      },
                      child: const Text('Forgot Password')),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditNumber()));
                      },
                      child: const Text('Login with phone number'))
                ],
              ),
            )));
  }
}
