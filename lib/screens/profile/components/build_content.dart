import 'package:flutter/material.dart';

class BuildContent extends StatelessWidget {
  const BuildContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          children: [
            const Divider(
              thickness: 1,
            ),
            const Text(
              'Username ',
              style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text('Lisandro',
                style: TextStyle(fontSize: 12.0, color: Colors.grey[600])),
            const Divider(
              thickness: 1,
            ),
            const Text(
              'Phone number ',
              style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text('+1 435093490',
                style: TextStyle(fontSize: 12.0, color: Colors.grey[600])),
            const Divider(
              thickness: 1,
            ),
            const Text(
              'Interests ',
              style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text('Football, Wrestling, Hockey and Rugby',
                style: TextStyle(fontSize: 12.0, color: Colors.grey[600])),
            const Divider(
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}
