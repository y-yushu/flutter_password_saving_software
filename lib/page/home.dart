import 'package:flutter/material.dart';
import 'package:flutter_password_saving_software/routes/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
        centerTitle: true,
        leading: const Icon(Icons.ac_unit_sharp),
      ),
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          // 导航到目标页面
          Navigator.pushNamed(context, testRoute);
        },
        child: const Text('Go to Second Screen222'),
      )),
    );
  }
}
