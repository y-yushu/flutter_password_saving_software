import 'dart:math';
import 'package:flutter/material.dart';
import 'package:azlistview/azlistview.dart';
import 'package:flutter_password_saving_software/global/global.dart';
import 'package:flutter_password_saving_software/hive/AccountAdapter.dart';
import 'package:flutter_password_saving_software/routes/routes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

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
          print('运行开始');
          Box<Account> box = Hive.box<Account>('mybox');
          // box.clear();
          String s = String.fromCharCode(Random().nextInt(26) + 97);
          Account ac = Account(title: '$s测试', username: s);
          box.put(ac.id, ac);
          print('运行完成');
        },
        child: const Icon(Icons.add),
      ),
      body: pageBody(context),
    );
  }

  Widget pageBody(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<Account>('mybox').listenable(),
      builder: (context, Box<Account> box, widget) {
        // 排序
        List<Account> list = box.values.toList();
        list.sort((a, b) => a.username.compareTo(b.username));
        // 渲染
        return AzListView(
          data: list,
          itemCount: list.length,
          itemBuilder: ((context, index) {
            Account ac = list[index];
            // return
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, editRoute, arguments: ac.id);
                // Navigator.pushNamed(context, editRoute);
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
