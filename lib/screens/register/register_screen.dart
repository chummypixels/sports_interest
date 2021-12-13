import 'package:flutter/material.dart';
import 'package:flutter_sports_interest/services/auth_service.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = "";

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _confirmPasswordController =
        TextEditingController();
    final double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    final authService = Provider.of<AuthService>(context);
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: Container(
            padding: EdgeInsets.only(left: 40, right: 40),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.04),
                  Text('Just a fun place to be',
                      style: TextStyle(fontSize: 30)),
                  Text('Welcomed', style: TextStyle(fontSize: 30)),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration:
                        const InputDecoration(labelText: 'Enter your email'),
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
                    //     return 'Please enter correct name';
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
                  SizedBox(
                    height: height * 0.05,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: _confirmPasswordController,
                    decoration: const InputDecoration(
                        labelText: 'Confirm your password'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value != _passwordController.text) {
                        return 'Password does not match';
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
                  ElevatedButton(
                    onPressed: () async {
                      final isValid = _formKey.currentState!.validate();

                      if (isValid) {
                        _formKey.currentState!.save();
                        //Here, we implement the register functionality
                        await authService.createUserWithEmailAndPassword(
                            _emailController.text, _passwordController.text);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Register'),
                  ),
                ],
              ),
            )));
  }
}
