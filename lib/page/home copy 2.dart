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
      body: pageBody(context),
    );
  }

  Widget pageBody(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    List<City> dataList = [
      City(name: '北京'),
      City(name: '北京2'),
      City(name: '北京3'),
      City(name: '北京4'),
      City(name: '上海'),
      City(name: '上海2'),
      City(name: '上海3'),
      City(name: '上海4'),
      City(name: '广州'),
      City(name: '广州2'),
      City(name: '广州3'),
      City(name: '广州4'),
      City(name: '重庆'),
      City(name: '重庆2'),
      City(name: '重庆3'),
      City(name: '重庆4'),
      City(name: '成都'),
      City(name: '成都2'),
      City(name: '成都3'),
      City(name: '成都4'),
      City(name: '长沙'),
      City(name: '长沙2'),
      City(name: '长沙3'),
      City(name: '长沙4'),
      City(name: '西安'),
      City(name: '西安2'),
      City(name: '西安3'),
      City(name: '西安4'),
      City(name: '济南'),
      City(name: '济南2'),
      City(name: '济南3'),
      City(name: '济南4'),
      City(name: '石家庄'),
      City(name: '石家庄2'),
      City(name: '石家庄3'),
      City(name: '石家庄4'),
      City(name: '沈阳'),
      City(name: '沈阳2'),
      City(name: '沈阳3'),
      City(name: '沈阳4'),
      City(name: '呼和浩特'),
      City(name: '呼和浩特2'),
      City(name: '呼和浩特3'),
      City(name: '呼和浩特4'),
      City(name: '新疆'),
      City(name: '新疆2'),
      City(name: '新疆3'),
      City(name: '新疆4'),
      City(name: '内蒙'),
      City(name: '内蒙2'),
      City(name: '内蒙3'),
      City(name: '内蒙4'),
      City(name: '郑州'),
      City(name: '郑州2'),
      City(name: '郑州3'),
      City(name: '郑州4'),
    ];
    // 对城市数据进行分组
    Map<String, List<City>> cityMap = {};
    for (var city in dataList) {
      String tag = city.getSuspensionTag();
      if (!cityMap.containsKey(tag)) {
        cityMap[tag] = [];
      }
      cityMap[tag]!.add(city);
    }

    // 将分组数据按首字母排序
    List<CityGroup> cityGroups = [];
    cityMap.forEach((tag, cities) {
      cities.sort((a, b) => a.name.compareTo(b.name));
      cityGroups.add(CityGroup(tag: tag, cities: cities));
    });
    cityGroups.sort((a, b) => a.tag.compareTo(b.tag));
    return AzListView(
      data: cityGroups,
      itemCount: cityGroups.length,
      itemBuilder: (context, i) {
        CityGroup citys = cityGroups[i];
        return Column(
          children: [
            getSusItem(width, citys.tag),
            ListView.builder(
              itemCount: citys.cities.length,
              itemBuilder: (context, i) {
                City city = citys.cities[i];
                return ListTile(
                  title: Text(city.name),
                );
              },
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
            ),
          ],
        );
      },
      // susItemBuilder: (context, i) {
      //   CityGroup city = cityGroups[i];
      //   return getSusItem(width, city.tag);
      // },
      susItemHeight: 40,
      physics: const AlwaysScrollableScrollPhysics(),
      indexBarData: cityGroups.map((e) => e.tag).toList(),
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

  Widget getSusItem(width, String name) {
    return SizedBox(
      width: width,
      height: 40,
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            name,
            style: const TextStyle(
              color: Color.fromRGBO(174, 178, 179, 1),
            ),
          ),
        ),
      ),
    );
  }
}

class CityGroup extends ISuspensionBean {
  String tag;
  List<City> cities;

  CityGroup({required this.tag, required this.cities});

  @override
  String getSuspensionTag() {
    return tag;
  }
}

class City extends ISuspensionBean {
  String name;

  City({required this.name});

  @override
  String getSuspensionTag() {
    String pinyin = PinyinHelper.getFirstWordPinyin(name);
    return pinyin.substring(0, 1).toUpperCase();
  }
}
