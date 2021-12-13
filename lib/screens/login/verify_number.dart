import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sports_interest/screens/onboarding/onboarding.dart';

import 'user_name.dart';

//setup enums for the two states of the app
enum Status { Waiting, Error }

class VerifyNumber extends StatefulWidget {
  final number;

  const VerifyNumber({Key? key, this.number}) : super(key: key);
  @override
  _VerifyNumberState createState() => _VerifyNumberState(number);
}

class _VerifyNumberState extends State<VerifyNumber> {
  final phoneNumber;
  var _status = Status.Waiting;
  var _verificationId;
  TextEditingController _textEditingController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  _VerifyNumberState(this.phoneNumber);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _verifyPhoneNumber();
  }

  //Implement the function to verify the phone number
  Future _verifyPhoneNumber() async {
    _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phonesCuthCredentials) async {},
        verificationFailed: (verificationFailed) async {},
        codeSent: (verificationId, resendingToken) async {
          setState(() {
            this._verificationId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (verificationId) async {});
  }

  //function to send code back to firebase
  Future _sendCodeToFirebase({String? code}) async {
    if (this._verificationId != null) {
      var credential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: code!);

      await _auth
          .signInWithCredential(credential)
          .then((value) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const OnBoardingScreen()));
          })
          .whenComplete(() {})
          .onError((error, stackTrace) {
            setState(() {
              _textEditingController.text = "";
              this._status = Status.Error;
            });
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Verify Number'),
        ),
        body: _status != Status.Error
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'OTP Verification',
                      style: TextStyle(
                          color: const Color(0XFF08C187).withOpacity(0.7),
                          fontSize: 30),
                    ),
                  ),
                  const Text(
                    'Enter OTP sent to',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(phoneNumber == null ? "" : phoneNumber),
                  TextField(
                    onChanged: (value) async {
                      print(value);
                      if (value.length == 6) {
                        //perform auth verification
                        _sendCodeToFirebase(code: value);
                      }
                    },
                    textAlign: TextAlign.center,
                    style: const TextStyle(letterSpacing: 30, fontSize: 30),
                    maxLength: 6,
                    controller: _textEditingController,
                    keyboardType: TextInputType.number,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Didn't receive the OTP?"),
                      TextButton(
                          onPressed: () async => _verifyPhoneNumber(),
                          child: const Text('RESEND OTP'))
                    ],
                  )
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'OTP Verification',
                      style: TextStyle(
                          color: const Color(0XFF08C187).withOpacity(0.7),
                          fontSize: 30),
                    ),
                  ),
                  const Text('The code used is Invalid'),
                  ElevatedButton(
                    child: const Text('Edit Number'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  ElevatedButton(
                    child: const Text('Resend Code'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ));
  }
}
