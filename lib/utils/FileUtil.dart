import 'dart:html';

import 'package:path_provider/path_provider.dart';

class FileUtil {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    print('应用文档路径:${directory.path}');
    return directory.path;
  }

  // Future<File> get _file async {
  //   final path = await _localPath;
  //   print('object');
  //   return new File('$path/flutter_demo.txt', 'flutter_demo');
  // }
}
