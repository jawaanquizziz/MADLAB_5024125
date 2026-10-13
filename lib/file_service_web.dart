import 'dart:convert';
import 'dart:html' as html;

Future<String> writeSampleFile(String content) async {
  final blob = html.Blob([utf8.encode(content)], 'text/plain');
  final url = html.Url.createObjectUrlFromBlob(blob);
  try {
    html.AnchorElement(href: url)
      ..setAttribute('download', 'sample.txt')
      ..click();
  } finally {
    html.Url.revokeObjectUrl(url);
  }
  return 'sample.txt created and downloaded successfully!';
}
