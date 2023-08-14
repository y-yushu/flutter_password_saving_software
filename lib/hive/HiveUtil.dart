import 'package:flutter_password_saving_software/hive/AccountAdapter.dart';
import 'package:hive_flutter/adapters.dart';

class HiveUtil {
  static Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter<Account>(AccountAdapter());
    await Hive.openBox<Account>('mybox');
  }
}
