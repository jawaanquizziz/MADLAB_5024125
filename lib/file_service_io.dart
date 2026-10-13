import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String> writeSampleFile(String content) async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/sample.txt');
  await file.writeAsString(content, flush: true);
  return 'sample.txt created and written successfully in app storage.';
}
