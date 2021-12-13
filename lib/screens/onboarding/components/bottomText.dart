import 'package:flutter/material.dart';

class BottomText extends StatelessWidget {
  final VoidCallback getStarted;

  const BottomText({Key? key, required this.getStarted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text.rich(
              TextSpan(
                style: Theme.of(context).textTheme.headline6,
                children: const [
                  TextSpan(text: "Let's Roll"),
                  TextSpan(
                    text: ' in style.',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () {
                getStarted();
              },
              child: const Text("GET STARTED"),
            )
          ],
        ),
      ),
    );
  }
}
