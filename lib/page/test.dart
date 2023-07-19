import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test')),
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          // 导航到目标页面
          Navigator.pushNamed(context, '/home');
        },
        child: const Text('Go to Home'),
      )),
    );
  }
}
