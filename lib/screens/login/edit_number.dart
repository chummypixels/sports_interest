import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'verify_number.dart';

//OTP class
class EditNumber extends StatefulWidget {
  const EditNumber({Key? key}) : super(key: key);

  @override
  _EditNumberState createState() => _EditNumberState();
}

class _EditNumberState extends State<EditNumber> {
  var _enterPhoneNumber = TextEditingController();
  //setup the country name and the country code
  Map<String, dynamic> data = {"name": "Nigeria", "code": "+234"};
  Map<String, dynamic>? dataResult;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Edit Number'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Logo(width: 80.0, height: 80.0, radius: 30.0),
              Text("Verification • one step",
                  style: TextStyle(
                      color: Color(0xFF08C187).withOpacity(0.7), fontSize: 30))
            ],
          ),
          Text("Enter your phone number",
              style: TextStyle(
                  color: CupertinoColors.systemGrey.withOpacity(0.7),
                  fontSize: 30)),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(data['code'],
                    style: TextStyle(
                        fontSize: 25, color: CupertinoColors.secondaryLabel)),
                Expanded(
                  child: CupertinoTextField(
                    placeholder: "Enter your phone number",
                    controller: _enterPhoneNumber,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                        fontSize: 25, color: CupertinoColors.secondaryLabel),
                  ),
                )
              ],
            ),
          ),
          const Text("You will receive an activation code in short time",
              style:
                  TextStyle(color: CupertinoColors.systemGrey, fontSize: 15)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: CupertinoButton.filled(
                child: Text("Request code"),
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => VerifyNumber(
                                number: data['code']! + _enterPhoneNumber.text,
                              )));
                }),
          )
        ],
      ),
    );
  }
}
