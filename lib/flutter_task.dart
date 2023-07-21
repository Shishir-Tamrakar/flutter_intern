import 'package:flutter/material.dart';
import 'wrapWidget.dart';
import 'listView.dart';

class FlutterTask extends StatefulWidget {
  const FlutterTask({super.key});

  @override
  State<FlutterTask> createState() => _FlutterTaskState();
}

class _FlutterTaskState extends State<FlutterTask> {
  bool showAllItems = false;
  bool showAllItemsIcons = false;
  String buttonTextCall() {
    if (showAllItems) {
      return "Show less";
    } else {
      return "Show more";
    }
  }

  String wrapShowMoreOrLess() {
    if (showAllItemsIcons) {
      return "Show less";
    } else {
      return "Show more";
    }
  }

  List<Map<String, dynamic>> imageList = [
    {
      'image': 'assets/guides.jpg',
      'title': 'Image 1',
      'dateTime': '2023/02/12 18:18'
    },
    {
      'image': 'assets/hills.jpg',
      'title': 'Image 2',
      'dateTime': '2023/02/12 18:18'
    },
    {
      'image': 'assets/hire.jpg',
      'title': 'Image 3',
      'dateTime': '2023/02/12 18:18'
    },
    {
      'image': 'assets/hireguide.jpg',
      'title': 'Image 4',
      'dateTime': '2023/02/12 18:18'
    },
    {
      'image': 'assets/homepage2.jpg',
      'title': 'Image 5',
      'dateTime': '2023/02/12 18:18'
    },
    {
      'image': 'assets/homepagephoto.jpg',
      'title': 'Image 6',
      'dateTime': '2023/02/12 18:18'
    },
    {
      'image': 'assets/homepagephoto1.jpg',
      'title': 'Image 7',
      'dateTime': '2023/02/12 18:18'
    },
    {
      'image': 'assets/nepalimage.jpg',
      'title': 'Image 8',
      'dateTime': '2023/02/12 18:18'
    },
    {
      'image': 'assets/background-2.png',
      'title': 'Image 9',
      'dateTime': '2023/02/12 18:18'
    },
    {
      'image': 'assets/nepalimage.jpg',
      'title': 'Image 10',
      'dateTime': '2023/02/12 18:18'
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Task 3'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 240.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: imageList.length,
                itemBuilder: (BuildContext context, int i) {
                  Map<String, dynamic> images = imageList[i];
                  return Container(
                    margin: EdgeInsets.all(10.0),
                    width: 200.0,
                    child: Column(
                      children: [
                        SizedBox(
                          child: Image.asset(images['image']),
                          height: 150,
                        ),
                        Text(images['title']),
                        Text(images['dateTime'])
                        // Container(
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(20.0),
                        //       boxShadow: [
                        //         BoxShadow(
                        //           color: Colors.black26,
                        //           offset: Offset(0.0, 2.0),
                        //           blurRadius: 6.0,
                        //         ),
                        //       ]),
                        //   child: FittedBox(
                        //     child: Image.asset(images['image']),
                        //     fit: BoxFit.fill,
                        //   ),
                        // ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              color: Colors.white,
              height: 330,
              width: 250,
              child: Column(
                children: [
                  Text(
                    'Images',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'The images can be scrolled',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Expanded(
                      child: ListViewImplement(
                    showAllItem: showAllItems,
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    showAllItems = !showAllItems;
                  });
                },
                child: Text(buttonTextCall())),
            SizedBox(
              height: 10.0,
            ),
            WrapImplement(
              showAllText: showAllItemsIcons,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    showAllItemsIcons = !showAllItemsIcons;
                  });
                },
                child: Text(wrapShowMoreOrLess()))
          ],
        ),
      ),
    );
  }
}
