import 'package:flutter/material.dart';
import 'flutter_task_4.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Task 4',
      home: FlutterTaskFour(),
    );
  }
}
