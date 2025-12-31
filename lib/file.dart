class MyFile {
  String name;
  String url;
  String? filePath;
  int size = 0;
  int progress = 0;
  bool isDownloading = false;
  bool isCompleted = false;
  
  MyFile(this.name, this.url);
}
