import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test')),
      body: Center(
          child: ElevatedButton(
        onPressed: () {},
        child: const Text('Go to Home22'),
      )),
    );
  }
}
