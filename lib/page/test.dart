import 'package:flutter/material.dart';
import 'package:flutter_password_saving_software/hive/AccountAdapter.dart';
import 'package:hive/hive.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    //录入数据
    Account account = Account(title: '');
    final formKey = GlobalKey<FormState>(); // 用于管理表单状态

    return Scaffold(
      appBar: AppBar(title: const Text('Test')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
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
                  onChanged: (value) {
                    account.username = value;
                  },
                  decoration: const InputDecoration(
                    labelText: '用户',
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
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
                      var box = Hive.box<Account>('mybox');
                      // box.add(account);
                      box.put('key', account);
                      print('yitijiao');
                    }
                  },
                  child: const Text('Submit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    var box = Hive.box<Account>('mybox');
                    // Account ac = box.getAt(0) as Account;
                    Account ac = box.get('key') as Account;
                    print(ac.title);
                    print(ac.username);
                    print(ac.password);
                  },
                  child: const Text('查看'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
