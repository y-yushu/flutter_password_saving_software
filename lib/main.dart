import 'package:flutter/material.dart';
import 'package:flutter_password_saving_software/hive/HiveUtil.dart';
import 'package:flutter_password_saving_software/routes/routes.dart';

void main() async {
  await HiveUtil.initHive();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: const Color.fromRGBO(22, 160, 133, 1)),
      initialRoute: homeRoute,
      routes: routes,
    );
  }
}
