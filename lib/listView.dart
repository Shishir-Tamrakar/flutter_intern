import 'package:flutter/material.dart';

class ListItem {
  final String title;
  final String description;
  final IconData icon;
  final String imagePath;

  ListItem(
      {required this.title,
      required this.description,
      required this.icon,
      required this.imagePath});
}

class ListViewImplement extends StatelessWidget {
  final bool showAllItem;
  ListViewImplement({super.key, required this.showAllItem});

  final List<ListItem> items = [
    ListItem(
      title: "Item 1",
      description: "Description for Item 1",
      icon: Icons.star,
      imagePath: "assets/guides.jpg",
    ),
    ListItem(
      title: "Item 2",
      description: "Description for Item 2",
      icon: Icons.access_alarm,
      imagePath: "assets/hills.jpg",
    ),
    ListItem(
      title: "Item 3",
      description: "Description for Item 3",
      icon: Icons.account_tree,
      imagePath: "assets/hireguide.jpg",
    ),
    ListItem(
      title: "Item 4",
      description: "Description for Item 4",
      icon: Icons.account_balance_sharp,
      imagePath: "assets/homepage2.jpg",
    ),
    ListItem(
      title: "Item 5",
      description: "Description for Item 5",
      icon: Icons.add_to_drive,
      imagePath: "assets/homepagephoto.jpg",
    ),
    ListItem(
      title: "Item 6",
      description: "Description for Item 6",
      icon: Icons.add_chart_rounded,
      imagePath: "assets/homepagephoto1.jpg",
    ),
    ListItem(
      title: "Item 7",
      description: "Description for Item 7",
      icon: Icons.add_business,
      imagePath: "assets/nepalimage.jpg",
    ),
    ListItem(
      title: "Item 8",
      description: "Description for Item 8",
      icon: Icons.ac_unit,
      imagePath: "assets/hire.jpg",
    ),
    ListItem(
      title: "Item 9",
      description: "Description for Item 9",
      icon: Icons.masks_sharp,
      imagePath: "assets/background-2.png",
    ),
    ListItem(
      title: "Item 10",
      description: "Description for Item 10",
      icon: Icons.add_location,
      imagePath: "assets/hills.jpg",
    )
  ];
  int listLength() {
    if (showAllItem) {
      return items.length;
    } else {
      return items.length - 5;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: items.take(listLength()).map((item) {
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
            width: 250,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 120,
                  child: Image.asset(
                    item.imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(item.icon),
                      SizedBox(width: 8),
                      Text(
                        item.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(item.description),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Add action for the button
                      print("Button for ${item.title} pressed.");
                    },
                    child: Text("Button"),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
