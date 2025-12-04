import 'dart:async';

import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool loading = true;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("بازی دوز", style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            if (loading) LinearProgressIndicator(),
            if (!loading)
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/suduku");
                },
                child: Text("رفتن به بازی"),
              ),
          ],
        ),
      ),
    );
  }
}
