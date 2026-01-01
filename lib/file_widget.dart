import 'package:flutter/material.dart';
import 'package:flutter_application_1/file.dart';

class FileWidget extends StatelessWidget {
  final MyFile file;
  final VoidCallback onDownload;
  final VoidCallback onCancel;
  final VoidCallback onOpen;

  const FileWidget({
    Key? key,
    required this.file,
    required this.onDownload,
    required this.onCancel,
    required this.onOpen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        title: Text(file.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            if (file.isDownloading || file.isCompleted)
              LinearProgressIndicator(
                value: file.size > 0 ? file.progress / file.size : null,
              ),
            SizedBox(height: 4),
            if (file.isDownloading || file.isCompleted)
              Text(
                file.size > 0
                    ? "${(file.progress / file.size * 100).toStringAsFixed(0)}%"
                    : "در حال دانلود...",
                style: TextStyle(fontSize: 12),
              ),
          ],
        ),
        trailing: file.isCompleted
            ? ElevatedButton(onPressed: onOpen, child: Text("باز کردن"))
            : file.isDownloading
            ? ElevatedButton(onPressed: onCancel, child: Text("لغو"))
            : ElevatedButton(onPressed: onDownload, child: Text("دانلود")),
      ),
    );
  }
}
