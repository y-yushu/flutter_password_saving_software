import 'package:flutter/material.dart';
import 'package:flutter_password_saving_software/page/home.dart';
import 'package:flutter_password_saving_software/page/test.dart';

// 定义路由
const String homeRoute = '/';
const String testRoute = '/test';

final Map<String, WidgetBuilder> routes = {
  homeRoute: (context) => const HomePage(),
  testRoute: (context) => const TestPage(),
};
