import 'package:flutter/material.dart';

class AsyncDemoPage extends StatefulWidget {
  const AsyncDemoPage({super.key});

  @override
  State<AsyncDemoPage> createState() => _AsyncDemoPageState();
}

class _AsyncDemoPageState extends State<AsyncDemoPage> {
  final List<String> dataList = [];

  Future<void> addFirstData() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      dataList.add('داده اول');
    });
  }

  Future<void> addSecondData() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      dataList.add('داده دوم');
    });
  }

  Future<void> addThirdData() async {
    await Future.delayed(const Duration(seconds: 5));
    setState(() {
      dataList.add('داده سوم');
    });
  }

  void startAsyncTasks() {
    dataList.clear();
    setState(() {});
    addFirstData();
    addSecondData();
    addThirdData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('غیر همزمانی')),
      body: Column(
        children: [
          const SizedBox(height: 16),

          ElevatedButton(
            onPressed: startAsyncTasks,
            child: const Text('شروع عملیات async'),
          ),

          const SizedBox(height: 16),

          Expanded(
            child: ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(dataList[index]));
              },
            ),
          ),
        ],
      ),
    );
  }
}
