import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/file.dart';
import 'package:flutter_application_1/file_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class DownloadManagerPage extends StatefulWidget {
  const DownloadManagerPage({super.key});
  @override
  State<DownloadManagerPage> createState() => _DownloadManagerPageState();
}

class _DownloadManagerPageState extends State<DownloadManagerPage> {
  final TextEditingController _urlController = TextEditingController();
  final Dio _dio = Dio();
  List<MyFile> files = [];
  final Map<MyFile, CancelToken> _cancelTokens = {};

  Future<void> addDownload() async {
    final url = _urlController.text;
    // if (url.isEmpty) {
    //   if (mounted) displayToast(context, "لطفا آدرس فایل را وارد کنید");
    //   return;
    // }

    // استخراج نام فایل از آدرس
    String fileName = url.split('/').last;
    // if (fileName.isEmpty || !fileName.contains('.')) {
    //   fileName = 'download_${DateTime.now().millisecondsSinceEpoch}';
    // }

    // دریافت پوشه دانلود
    final directory = await getDownloadsDirectory();
    final filePath = '${directory!.path}/$fileName';

    // ایجاد فایل جدید و اضافه کردن به لیست
    final newFile = MyFile(fileName, url);
    newFile.filePath = filePath;

    setState(() {
      files.add(newFile);
    });

    _urlController.clear();
    // downloadFile(newFile);
  }

  Future<void> downloadFile(MyFile file) async {
    if (file.isDownloading) return;

    setState(() {
      file.isDownloading = true;
      file.progress = 0;
    });

    final cancelToken = CancelToken();
    _cancelTokens[file] = cancelToken;

    try {
      await _dio.download(
        file.url,
        file.filePath,
        cancelToken: cancelToken,
        onReceiveProgress: (received, total) {
          setState(() {
            file.progress = received;
            file.size = total;
          });
        },
      );

      setState(() {
        file.isDownloading = false;
        file.isCompleted = true;
      });
      _cancelTokens.remove(file);
    } catch (e) {
      _cancelTokens.remove(file);
      setState(() {
        file.isDownloading = false;
      });
      if (e is! DioException || e.type != DioExceptionType.cancel) {
        if (mounted) displayToast(context, "خطا در دانلود فایل");
      }
    }
  }

  void cancelDownload(MyFile file) {
    _cancelTokens[file]?.cancel();
    File(file.filePath!).deleteSync();

    setState(() {
      file.isDownloading = false;
      file.progress = 0;
    });
  }

  Future<void> openFile(MyFile file) async {
    await OpenFile.open(file.filePath);
  }

  @override
  void dispose() {
    for (var token in _cancelTokens.values) {
      token.cancel();
    }
    _dio.close();
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("دانلود منیجر")),
      body: Column(
        children: [
          // بخش ورود آدرس
          addFileWidget(),
          Divider(),
          // لیست فایل‌ها
          Expanded(
            child: files.isEmpty
                ? Center(
                    child: Text(
                      "هیچ فایلی برای دانلود وجود ندارد",
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView(
                    children: files
                        .map(
                          (file) => FileWidget(
                            file: file,
                            onDownload: () => downloadFile(file),
                            onCancel: () => cancelDownload(file),
                            onOpen: () => openFile(file),
                          ),
                        )
                        .toList(),
                  ),
          ),
        ],
      ),
    );
  }

  Widget addFileWidget() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _urlController,
              // decoration: InputDecoration(
              //   labelText: "آدرس فایل",
              //   border: OutlineInputBorder(
              //     borderRadius: BorderRadius.circular(25),
              //   ),
              // ),
            ),
          ),
          SizedBox(width: 8),
          ElevatedButton(onPressed: addDownload, child: Text("افزودن")),
        ],
      ),
    );
  }
}
