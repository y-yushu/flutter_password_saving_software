import 'package:flutter/material.dart';
import 'package:flutter_password_saving_software/page/edit.dart';
import 'package:flutter_password_saving_software/page/home.dart';
import 'package:flutter_password_saving_software/page/setting.dart';
import 'package:flutter_password_saving_software/page/test.dart';

// 定义路由
const String homeRoute = '/'; // 首页
const String settingRoute = '/setting'; // 设置页
const String editRoute = '/edit'; // 编辑页
const String testRoute = '/test'; // 测试页

final Map<String, WidgetBuilder> routes = {
  // homeRoute: (context) => const TestPage(),
  homeRoute: (context) => const HomePage(),
  settingRoute: (context) => const SettingPage(),
  editRoute: (context) => const EditPage(),
  testRoute: (context) => const TestPage(),
};
