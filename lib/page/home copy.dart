import 'package:flutter/material.dart';
import 'package:azlistview/azlistview.dart';
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
