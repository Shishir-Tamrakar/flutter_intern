import 'package:flutter/material.dart';
import 'flutter_task_2.dart';
import 'flutter_task.dart';
import 'gridView.dart';
import 'customScrollView.dart';

class FlutterTaskFour extends StatefulWidget {
  const FlutterTaskFour({super.key});

  @override
  State<FlutterTaskFour> createState() => _FlutterTaskFourState();
}

class _FlutterTaskFourState extends State<FlutterTaskFour> {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Assesment 4'),
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CustomScrollImplement()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {},
            ),
          ],
          bottom: const TabBar(tabs: [
            Tab(icon: Icon(Icons.looks_two), text: 'Day 2 Tab'),
            Tab(icon: Icon(Icons.looks_3), text: 'Day 3 Tab'),
            Tab(icon: Icon(Icons.looks_4), text: 'Day 4 Tab'),
          ]),
        ),
        body: const TabBarView(children: [
          FlutterTaskTwo(),
          FlutterTask(),
          GridViewImplement(),
        ]),
      ),
    );
  }
}
