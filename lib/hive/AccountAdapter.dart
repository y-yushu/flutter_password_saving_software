import 'package:azlistview/azlistview.dart';
import 'package:flutter_password_saving_software/global/global.dart';
import 'package:hive/hive.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:uuid/uuid.dart';

@HiveType(typeId: 0)
class Account extends HiveObject with ISuspensionBean {
  @HiveField(0)
  String id; // 唯一键
  @HiveField(1)
  String title; // 标题
  @HiveField(2)
  String username; // 用户名
  @HiveField(3)
  String password; // 密码
  @HiveField(4)
  bool collect; // 是否收藏（置顶）

  Account({
    required this.title,
    this.username = '',
    this.password = '',
    this.collect = false,
  }) : id = const Uuid().v4();

  @override
  String getSuspensionTag() {
    if (collect) return Global().star;
    String pinyin = PinyinHelper.getFirstWordPinyin(title);
    return pinyin.substring(0, 1).toUpperCase();
  }
}

class AccountAdapter extends TypeAdapter<Account> {
  @override
  final int typeId = 0;

  @override
  Account read(BinaryReader reader) {
    return Account(
      title: reader.read(),
      username: reader.read(),
      password: reader.read(),
      collect: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Account obj) {
    writer
      ..write(obj.title)
      ..write(obj.username)
      ..write(obj.password)
      ..write(obj.collect);
  }
}
