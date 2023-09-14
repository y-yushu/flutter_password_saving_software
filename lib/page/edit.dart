/// 编辑（新增）
import 'package:flutter/material.dart';
import 'package:flutter_password_saving_software/hive/AccountAdapter.dart';
import 'package:flutter_password_saving_software/hive/HiveUtil.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

/// 新增/编辑页
class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  //录入数据
  Account account = Account(id: '', title: '');
  final formKey = GlobalKey<FormState>(); // 用于管理表单状态
  @override
  Widget build(BuildContext context) {
    String? id = ModalRoute.of(context)?.settings.arguments as String?;
    account = getAccount(id);
    String title = id == null ? '新建' : '修改';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () {
              var box = Hive.box<Account>(HiveUtil.lockBox);
              box.delete(account.id);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: account.title,
                  onChanged: (value) {
                    account.title = value;
                  },
                  decoration: const InputDecoration(labelText: '标题'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '必填';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: account.username,
                  onChanged: (value) {
                    account.username = value;
                  },
                  decoration: const InputDecoration(
                    labelText: '用户',
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: account.password,
                  onChanged: (value) {
                    account.password = value;
                  },
                  decoration: const InputDecoration(
                    labelText: '密码',
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // 如果表单验证通过
                      // 执行提交操作或其他操作
                      var box = Hive.box<Account>(HiveUtil.lockBox);
                      box.put(account.id, account);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('提交'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 判断是新增还是修改
  Account getAccount(String? id) {
    if (id == null) {
      String id = const Uuid().v4();
      Account ac = Account(id: id, title: '');
      return ac;
    } else {
      var box = Hive.box<Account>(HiveUtil.lockBox);
      Account ac = box.get(id) as Account;
      return ac;
    }
  }
}
