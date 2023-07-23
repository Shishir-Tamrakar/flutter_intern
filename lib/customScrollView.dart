import 'package:flutter/material.dart';

class CustomScrollImplement extends StatefulWidget {
  const CustomScrollImplement({super.key});

  @override
  State<CustomScrollImplement> createState() => _CustomScrollImplementState();
}

class _CustomScrollImplementState extends State<CustomScrollImplement> {
  List<String> items = List.generate(50, (index) => "Item ${index + 1}");

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            title: Text("Custom Scroll View"),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return buildListItem(items[index]);
            },
            childCount: items.length,
          ),
        ),
      ],
    );
  }

  Widget buildListItem(String item) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(item.substring(item.length - 1)),
        ),
        title: Text(item),
        subtitle: Text("This is a subtitle for $item."),
        onTap: () {
          // Do something when the item is tapped.
        },
      ),
    );
  }
}
