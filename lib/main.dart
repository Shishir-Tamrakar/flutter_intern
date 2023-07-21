import 'package:flutter/material.dart';
import 'flutter_task.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Task 3',
      home: FlutterTask(),
    );
  }
}
