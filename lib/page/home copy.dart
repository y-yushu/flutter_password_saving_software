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
  ScrollController scrollController = ScrollController();
  bool _isFabVisible = true;

  @override
  void initState() {
    super.initState();

    // 监听滚动事件
    print('kais监听');
    scrollController.addListener(() {
      print(scrollController.position.userScrollDirection);
      // if (scrollController.position.userScrollDirection ==
      //     ScrollDirection.forward) {
      //   print('111111111111');
      //   // 上滑显示
      //   // if (!_isFabVisible) {
      //   // setState(() {
      //   //   _isFabVisible = true;
      //   // });
      //   // }
      // } else if (scrollController.position.userScrollDirection ==
      //     ScrollDirection.reverse) {
      //   print('22222222');
      //   // 下拉隐藏
      //   // if (_isFabVisible) {
      //   // setState(() {
      //   //   _isFabVisible = false;
      //   // });
      //   // }
      // }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('卡片列表'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: pageDrawer(),
      floatingActionButton: pageButton(context),
      // body: pageBody(context),
      body: pageTTT(context),
    );
  }

  Widget pageTTT(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Item $index'),
        );
      },
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
              leading: Icon(Icons.css),
              title: Text('主页2'),
              onTap: () {
                print('object');
              },
            ),
          ],
        ),
      ),
    );
  }

  // 页面新增按钮
  Widget pageButton(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        print('123');
        return true;
      },
      child: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, editRoute);
        },
        child: const Icon(Icons.add),
      ),
    );
    // return _isFabVisible
    //     ? FloatingActionButton(
    //         backgroundColor: Theme.of(context).primaryColor,
    //         onPressed: () {
    //           Navigator.pushNamed(context, editRoute);
    //         },
    //         child: const Icon(Icons.add),
    //       )
    //     : const SizedBox();
  }
}
