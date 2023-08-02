import 'package:flutter/material.dart';
import 'package:azlistview/azlistview.dart';
import 'package:flutter_password_saving_software/constant/global.dart';
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
      body: pageBody(context),
    );
  }

  Widget pageBody(BuildContext context) {
    List<City> dataList = [
      City(name: 'JJJ 收藏', collect: true),
      City(name: 'AAA'),
      City(name: 'BBB'),
      City(name: 'CCC'),
      City(name: 'DDD'),
      City(name: 'EEE'),
      City(name: 'FFF'),
      City(name: 'GGG'),
      City(name: 'HHH'),
      City(name: 'III'),
      City(name: 'JJJ'),
      City(name: 'KKK'),
      City(name: 'LLL'),
      City(name: 'MMM'),
      City(name: 'NNN'),
      City(name: 'OOO'),
      City(name: 'PPP'),
      City(name: 'RRR'),
      City(name: 'SSS'),
      City(name: 'TTT'),
      City(name: 'UUU'),
      City(name: 'VVV'),
      City(name: 'WWW'),
      City(name: 'XXX'),
      City(name: 'YYY'),
      City(name: 'ZZZ'),
      City(name: '#ZZZ'),
    ];
    return AzListView(
      data: dataList,
      itemCount: dataList.length,
      itemBuilder: (context, i) {
        City city = dataList[i];
        return ListTile(
          title: Text(city.name),
        );
      },
      indexBarData: [Global().star, ...kIndexBarData],
      indexBarOptions: const IndexBarOptions(
        needRebuild: true,
        selectTextStyle: TextStyle(
          fontSize: 12,
          color: Color(0xFF2196f3),
          fontWeight: FontWeight.w900,
        ),
        selectItemDecoration: BoxDecoration(),
      ),
    );
  }
}

class City extends ISuspensionBean {
  String name;
  bool collect;

  City({required this.name, this.collect = false});

  @override
  String getSuspensionTag() {
    if (collect) return Global().star;
    String pinyin = PinyinHelper.getFirstWordPinyin(name);
    return pinyin.substring(0, 1).toUpperCase();
  }
}
