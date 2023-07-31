import 'package:flutter/material.dart';
import 'package:azlistview/azlistview.dart';
import 'package:flutter_password_saving_software/entity/account.dart';
import 'package:lpinyin/lpinyin.dart';

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
        title: const Text('城市列表'),
      ),
      body: Body(context),
    );
  }

  Widget Body(BuildContext context) {
    List<String> sitys = [
      '北京',
      '重庆',
      '成都',
      '长沙',
      '上海',
      '西安',
    ];
    List<City> dataList = sitys.map((e) => City(name: e)).toList();
    return AzListView(
      data: dataList,
      itemCount: dataList.length,
      itemBuilder: (context, i) {
        City data = dataList[i];
        return ListTile(
          title: Text(data.name),
        );
      },
      indexBarData: ['⭐', ...kIndexBarData],
    );
    Account data1 = Account(name: 'QQ');
    Account data2 = Account(name: '微信');
    Account data3 = Account(name: '飞书');
    Account data4 = Account(name: '网易');
    Account data5 = Account(name: 'Office');
    List<Account> list = [
      // data1,
      // data2,
      // data3,
      // data4,
      // data5,
      Account(name: '阿拉伯'),
      Account(name: 'WX-1'),
      Account(name: 'WX0'),
      Account(name: 'WX1'),
      Account(name: 'WX2'),
      Account(name: 'WX3'),
      // Account(name: 'WX4', ttt: true),
      Account(name: 'WX5'),
      Account(name: 'WX6'),
      Account(name: 'WX7'),
      Account(name: 'WX6'),
      Account(name: 'WX8'),
      Account(name: 'WX9'),
      Account(name: 'WX10'),
      Account(name: 'WX11'),
      Account(name: 'Z'),
    ];
    return AzListView(
      data: list,
      itemCount: list.length,
      itemBuilder: (context, i) {
        Account data = list[i];
        return ListTile(
          title: Text(data.name),
        );
      },
      // indexBarData: ['A', '☆', 'W', 'Z'],
    );
  }
}

class City extends ISuspensionBean {
  String name;

  City({required this.name});

  @override
  String getSuspensionTag() {
    // if (name == '北京') {
    String s = PinyinHelper.getFirstWordPinyin(name);
    return s.substring(0, 1).toUpperCase();
    // } else {
    //   return '@';
    // }
  }
}
