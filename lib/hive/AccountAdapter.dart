import 'package:azlistview/azlistview.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Account extends HiveObject with ISuspensionBean {
  @HiveField(0)
  String title;
  @HiveField(1)
  String username;
  @HiveField(2)
  String password;

  Account({
    required this.title,
    this.username = '',
    this.password = '',
  });

  @override
  String getSuspensionTag() {
    return 'A';
  }
}

class AccountAdapter extends TypeAdapter<Account> {
  @override
  final int typeId = 0;

  @override
  Account read(BinaryReader reader) {
    return Account(
      title: reader.read(),
      username: reader.read(),
      password: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Account obj) {
    writer
      ..write(obj.title)
      ..write(obj.username)
      ..write(obj.password);
  }
}
