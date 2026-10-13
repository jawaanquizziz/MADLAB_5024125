import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/material.dart';

void main() {
  runApp(const Practical8App());
}

class Practical8App extends StatelessWidget {
  const Practical8App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Practical 8',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6750A4),
        ),
      ),
      home: const FileHandlingPage(),
    );
  }
}

class FileHandlingPage extends StatefulWidget {
  const FileHandlingPage({super.key});

  @override
  State<FileHandlingPage> createState() => _FileHandlingPageState();
}

class _FileHandlingPageState extends State<FileHandlingPage> {
  String fileContent = '';
  String status = 'No file operation performed yet.';
  bool success = false;
  bool error = false;

  // ACTUAL CREATE + WRITE OPERATION
  void createAndWriteFile() {
    try {
      const content =
          'Hello from Flutter!\n\n'
          'This is Practical 8 - File Handling.\n'
          'This text was actually written into a file using Flutter.';

      final bytes = utf8.encode(content);

      final blob = html.Blob(
        [bytes],
        'text/plain',
      );

      final url = html.Url.createObjectUrlFromBlob(blob);

      html.AnchorElement(href: url)
        ..setAttribute('download', 'sample.txt')
        ..click();

      html.Url.revokeObjectUrl(url);

      setState(() {
        fileContent = content;
        status = 'sample.txt created and written successfully!';
        success = true;
        error = false;
      });
    } catch (e) {
      setState(() {
        status = 'Error while creating/writing file: $e';
        error = true;
        success = false;
      });
    }
  }

  // ACTUAL READ OPERATION
  void readFile() {
    final input = html.FileUploadInputElement()
      ..accept = '.txt,text/plain';

    input.click();

    input.onChange.listen((event) {
      final files = input.files;

      if (files == null || files.isEmpty) {
        return;
      }

      final file = files.first;

      final reader = html.FileReader();

      reader.readAsText(file);

      reader.onLoad.listen((event) {
        setState(() {
          fileContent = reader.result.toString();
          status = '${file.name} read successfully!';
          success = true;
          error = false;
        });
      });

      reader.onError.listen((event) {
        setState(() {
          status = 'Error while reading file.';
          error = true;
          success = false;
        });
      });
    });
  }

  void clearFile() {
    setState(() {
      fileContent = '';
      status = 'No file operation performed yet.';
      success = false;
      error = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F5FA),
      appBar: AppBar(
        title: const Text(
          'Practical 8 - File Handling',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 850),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Header
                const Text(
                  'File Management',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Create, write, read and display a text file.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 28),

                // Operation card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Text(
                        'File Operations',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      const Text(
                        'Perform real file operations using the browser.',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 24),

                      Row(
                        children: [

                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: createAndWriteFile,
                              icon: const Icon(
                                Icons.save_rounded,
                              ),
                              label: const Text(
                                'Create & Write',
                              ),
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(
                                  vertical: 17,
                                ),
                                backgroundColor:
                                    const Color(0xFF6750A4),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 14),

                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: readFile,
                              icon: const Icon(
                                Icons.file_open_rounded,
                              ),
                              label: const Text(
                                'Read File',
                              ),
                              style: OutlinedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(
                                  vertical: 17,
                                ),
                                foregroundColor:
                                    const Color(0xFF6750A4),
                                side: const BorderSide(
                                  color: Color(0xFF6750A4),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      SizedBox(
                        width: double.infinity,
                        child: TextButton.icon(
                          onPressed: clearFile,
                          icon: const Icon(Icons.clear),
                          label: const Text('Clear'),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Status
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: error
                        ? const Color(0xFFFFEBEE)
                        : success
                            ? const Color(0xFFE8F5E9)
                            : const Color(0xFFF0EDF5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        error
                            ? Icons.error_rounded
                            : success
                                ? Icons.check_circle_rounded
                                : Icons.info_rounded,
                        color: error
                            ? Colors.red
                            : success
                                ? Colors.green
                                : const Color(0xFF6750A4),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          status,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // File content
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E24),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [

                      Row(
                        children: [
                          const Icon(
                            Icons.description_rounded,
                            color: Color(0xFFB9A8E8),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'File Content',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: const Color(0xFF292830),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          fileContent.isEmpty
                              ? 'No file content loaded.'
                              : fileContent,
                          style: const TextStyle(
                            color: Color(0xFFE8E4EC),
                            fontSize: 15,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Practical requirements
                const Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _Tag(text: 'Create File'),
                    _Tag(text: 'Write File'),
                    _Tag(text: 'Read File'),
                    _Tag(text: 'Display Content'),
                    _Tag(text: 'Error Handling'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String text;

  const _Tag({required this.text});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(text),
      avatar: const Icon(
        Icons.check,
        size: 16,
      ),
    );
  }
}