import 'package:flutter/material.dart';
import 'package:flutter_password_saving_software/entity/account.dart';
// import 'package:dropdown_search/dropdown_search.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    //录入数据
    Account account = Account(title: '');

    return Scaffold(
      appBar: AppBar(title: const Text('Test')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  account.title = value;
                },
                decoration: const InputDecoration(
                  labelText: '标题',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: (value) {
                  account.username = value;
                },
                decoration: const InputDecoration(
                  labelText: '用户',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
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
                  print('===' + account.title);
                  print('$account');
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
