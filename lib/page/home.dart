import 'package:flutter/material.dart';
import 'package:azlistview/azlistview.dart';
import 'package:flutter_password_saving_software/global/global.dart';
import 'package:flutter_password_saving_software/hive/AccountAdapter.dart';
import 'package:flutter_password_saving_software/hive/HiveUtil.dart';
import 'package:flutter_password_saving_software/routes/routes.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
        title: const Text('卡片列表'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, editRoute);
        },
        child: const Icon(Icons.add),
      ),
      body: pageBody(context),
    );
  }

  Widget pageBody(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<Account>(HiveUtil.lockBox).listenable(),
      builder: (context, Box<Account> box, widget) {
        // 排序
        List<Account> list = box.values.toList();
        list.sort((a, b) => PinyinHelper.getFirstWordPinyin(a.title)
            .compareTo(PinyinHelper.getFirstWordPinyin(b.title)));
        // 渲染
        return AzListView(
          data: list,
          itemCount: list.length,
          itemBuilder: ((context, index) {
            Account ac = list[index];
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, editRoute, arguments: ac.id);
              },
              child: ListTile(
                title: Text(ac.title),
              ),
            );
          }),
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
      },
    );
  }
}
