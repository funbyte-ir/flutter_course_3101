import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/file.dart';

class DownloadManagerPage extends StatefulWidget {
  @override
  State<DownloadManagerPage> createState() => _DownloadManagerPageState();
}

class _DownloadManagerPageState extends State<DownloadManagerPage> {
  List<MyFile> files = [
    MyFile("File 1", 10),
    MyFile("File 2", 20),
    MyFile("File 3", 50),
  ];
  Future<void> downloadFile(MyFile file) async {
    file.progress = 0;
    Timer.periodic(Duration(seconds: 1), (timer) {
      file.progress += 1;
      if (file.progress >= file.size) {
        timer.cancel();
        return;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Download Manager")),
      body: ListView(
        children: files
            .map(
              (file) => ListTile(
                title: Text(file.name),
                trailing: ElevatedButton(
                  onPressed: () {
                    downloadFile(file);
                  },
                  child: Text(file.progress == 0 ? "دانلود" : "کنسل"),
                ),
                subtitle: LinearProgressIndicator(
                  value: file.progress / file.size,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
