import 'package:flutter/material.dart';
import 'dart:math';

class GridViewImplement extends StatefulWidget {
  const GridViewImplement({super.key});

  @override
  State<GridViewImplement> createState() => _GridViewImplementState();
}

class _GridViewImplementState extends State<GridViewImplement> {
  List<Color> colorList = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
  ];
  bool showAllItems = false;
  List<Map<String, dynamic>> titles = [
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
    },
    {
      'image': 'assets/guides.jpg',
      'title': 'Image 11',
      'dateTime': '2023/02/12 18:18'
    },
    {
      'image': 'assets/hills.jpg',
      'title': 'Image 12',
      'dateTime': '2023/02/12 18:18'
    },
    {
      'image': 'assets/hire.jpg',
      'title': 'Image 13',
      'dateTime': '2023/02/12 18:18'
    },
    {
      'image': 'assets/hireguide.jpg',
      'title': 'Image 14',
      'dateTime': '2023/02/12 18:18'
    },
    {
      'image': 'assets/homepage2.jpg',
      'title': 'Image 15',
      'dateTime': '2023/02/12 18:18'
    },
    {
      'image': 'assets/homepagephoto.jpg',
      'title': 'Image 16',
      'dateTime': '2023/02/12 18:18'
    },
    {
      'image': 'assets/homepagephoto1.jpg',
      'title': 'Image 17',
      'dateTime': '2023/02/12 18:18'
    },
    {
      'image': 'assets/nepalimage.jpg',
      'title': 'Image 18',
      'dateTime': '2023/02/12 18:18'
    },
    {
      'image': 'assets/background-2.png',
      'title': 'Image 19',
      'dateTime': '2023/02/12 18:18'
    },
    {
      'image': 'assets/nepalimage.jpg',
      'title': 'Image 20',
      'dateTime': '2023/02/12 18:18'
    }
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              "Title",
              style: TextStyle(fontSize: 15.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Sub Title",
              style: TextStyle(fontSize: 12.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "2023/06/02 18:18",
              style: TextStyle(fontSize: 12.0),
            ),
            SizedBox(
              height: 10,
            ),
            buildGridView(showAllItems ? titles.length : 10),
            Divider(
              color: Colors.black, // Set the color of the divider here
              thickness: 10, // Set the thickness of the divider here
            ),
            SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    showAllItems = !showAllItems;
                  });
                },
                child: Text(showAllItems ? "Show less" : "Show more"))
          ],
        ),
      ),
    );
  }

  Widget buildGridView(int count) {
    int colorIndex = Random().nextInt(colorList.length);

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      itemCount: count,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        Map<String, dynamic> title = titles[index];
        return Container(
          color: colorList[colorIndex],
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title['title'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 100.0,
                width: 200.0,
                child: Image.asset(title['image']),
              )
            ],
          ),
        );
      },
    );
  }
}
