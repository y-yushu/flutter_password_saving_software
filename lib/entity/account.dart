import 'package:azlistview/azlistview.dart';
import 'package:flutter_password_saving_software/constant/global.dart';
import 'package:lpinyin/lpinyin.dart';

// 账号
class Account extends ISuspensionBean {
  String title; // 标题
  String icon; // 图标
  int sort; // 排序
  String officialWebsite; // 官网
  String name; // 昵称（名称）
  String email; // 邮箱
  String phone; // 手机
  String password; // 密码
  List<String> bindAccount; // 绑定账号（可用于登录）
  List<String> associatedAccount; // 关联账号（仅用作关联）
  String type; // 分类
  String remark; // 备注
  Map<String, dynamic> additionItem; // 其他
  bool collect; // 是否收藏

  Account({
    this.title = "",
    this.icon = "",
    this.sort = 1,
    this.officialWebsite = "",
    this.name = "",
    this.email = "",
    this.phone = "",
    this.password = "",
    this.bindAccount = const [],
    this.associatedAccount = const [],
    this.type = "",
    this.remark = "",
    this.additionItem = const {},
    this.collect = false,
  });

  @override
  String getSuspensionTag() {
    if (collect) return Global().star;
    String pinyin = PinyinHelper.getFirstWordPinyin(name);
    return pinyin.substring(0, 1).toUpperCase();
  }

  /// 获取拼音首字母
  String getPinyin() {
    if (collect) return Global().star;
    String pinyin = PinyinHelper.getFirstWordPinyin(name);
    return pinyin.substring(0, 1).toUpperCase();
  }
}
