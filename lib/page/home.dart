import 'package:flutter/material.dart';

/// 首页
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
      body: Body(context),
    );
  }

  Widget Body(BuildContext context) {
    return SizedBox(
      child: Text('data'),
    );
  }
}
