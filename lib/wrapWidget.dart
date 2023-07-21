import 'package:flutter/material.dart';

class ListOfText {
  final String text;
  final IconData icons;
  ListOfText({required this.text, required this.icons});
}

class WrapImplement extends StatelessWidget {
  final bool showAllText;
  WrapImplement({super.key, required this.showAllText});
  final List<ListOfText> listTextIcon = [
    ListOfText(text: "text 1", icons: Icons.accessibility_sharp),
    ListOfText(text: "text 2", icons: Icons.add_a_photo),
    ListOfText(text: "text 3", icons: Icons.account_balance_rounded),
    ListOfText(text: "text 4", icons: Icons.airline_seat_recline_extra_rounded),
    ListOfText(text: "text 5", icons: Icons.hail),
    ListOfText(text: "text 6", icons: Icons.add_shopping_cart),
    ListOfText(text: "text 7", icons: Icons.yard_sharp),
    ListOfText(text: "text 8", icons: Icons.offline_bolt),
    ListOfText(text: "text 9", icons: Icons.celebration),
    ListOfText(text: "text 10", icons: Icons.face),
  ];
  int itemCount() {
    if (showAllText) {
      return listTextIcon.length;
    } else {
      return listTextIcon.length - 5;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: listTextIcon.take(itemCount()).map((items) {
        return Chip(
            label: Row(
          children: [
            Icon(items.icons),
            SizedBox(
              width: 4.0,
            ),
            Text(items.text)
          ],
        ));
      }).toList(),
    );
  }
}
