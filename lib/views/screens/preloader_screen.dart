import 'package:flutter/material.dart';

class PreloaderScreen extends StatelessWidget {
  PreloaderScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SizedBox(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        CircularProgressIndicator(),
        SizedBox(
          height: 10,
        ),
        Text('Uploading video...')
      ]),
    )));
  }
}
