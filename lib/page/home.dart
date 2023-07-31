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
    final List<String> sitys = [
      "安庆",
      "保定",
      "CangZhou",
      "ChangChun",
      "GuiZhou",
      "HaErBin",
      "HuiZhou",
      "HuNan",
      "HuZhou",
      "吉安",
      "JiangSu",
      "JiangXi",
      "JinHua",
      "JiNing",
      "JiXi",
      "KunMing",
      "LangFang",
      "LinYi",
      "LiuZhou",
      "LuoYang",
      "MeiZhou",
      "NanYang",
      "NeiMengGu",
      "NingXia",
      "青岛",
      "QingHai",
      "QuanZhou",
      "RiZhao",
      "SanYa",
      "SuZhou",
      "TaiWan",
      "TaiYuan",
      "TaiZhou",
      "TaiZhou",
      "TianJin",
      "WenZhou",
      "WuHan",
      "WuHu",
      "WuLuMuQi",
      "厦门",
      "XiAn",
    ];
    final List<City> dataList = sitys.map((e) => City(name: e)).toList();
    return AzListView(
      data: dataList,
      itemCount: dataList.length,
      itemBuilder: (context, i) {
        City city = dataList[i];
        return ListTile(
          title: Text(city.name),
        );
      },
      indexBarData: ['☆', 'A', 'B', 'C', 'X'],
    );
  }
}

class City extends ISuspensionBean {
  String name;

  City({required this.name});

  @override
  String getSuspensionTag() {
    String s = PinyinHelper.getFirstWordPinyin(name);
    return s.substring(0, 1).toUpperCase();
  }
}
