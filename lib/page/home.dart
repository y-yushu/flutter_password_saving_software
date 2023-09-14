import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:azlistview/azlistview.dart';
import 'package:flutter/rendering.dart';
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
  bool _isFabVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('卡片列表'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: pageDrawer(),
      floatingActionButton: pageButton(context),
      body: pageBody(context),
    );
  }

  // 页面主体
  Widget pageBody(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<Account>(HiveUtil.lockBox).listenable(),
      builder: (context, Box<Account> box, widget) {
        // 排序
        List<Account> list = box.values.toList();
        list.sort((a, b) => PinyinHelper.getFirstWordPinyin(a.title)
            .compareTo(PinyinHelper.getFirstWordPinyin(b.title)));
        // 渲染
        return NotificationListener(
          onNotification: (notification) {
            if (notification is ScrollUpdateNotification) {
              if (notification.scrollDelta! > 0) {
                if (_isFabVisible) {
                  setState(() {
                    _isFabVisible = false;
                  });
                }
              } else if (notification.scrollDelta! < 0) {
                if (!_isFabVisible) {
                  setState(() {
                    _isFabVisible = true;
                  });
                }
              }
            }
            return true;
          },
          child: AzListView(
            data: list,
            itemCount: list.length,
            itemBuilder: ((context, index) {
              Account ac = list[index];
              print(index);
              print(ac.id);
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
          ),
        );
      },
    );
  }

  // 页面左滑窗口
  Widget pageDrawer() {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('设置'),
              onTap: () {
                Navigator.pushNamed(context, settingRoute);
              },
            ),
            Divider(),
            ListTile(
              leading: const Icon(Icons.vertical_align_bottom),
              title: const Text('导出'),
              onTap: () {
                print('执行导出');
                var box = Hive.box<Account>(HiveUtil.lockBox);
                var list = box.values.toList();
                List<Map<String, dynamic>> datas =
                    list.map((e) => e.toData()).toList();
                String str = jsonEncode(datas);
                print(str);
              },
            ),
          ],
        ),
      ),
    );
  }

  // 页面新增按钮
  Widget pageButton(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200), // 动画持续时间
      height: _isFabVisible ? 56.0 : 0.0, // 控制高度
      width: _isFabVisible ? 56.0 : 0.0, // 控制宽度
      child: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.pushNamed(context, editRoute);
        },
        child: const Icon(Icons.add),
      ), // 当不可见时不渲染 FloatingActionButton
    );
  }
}
