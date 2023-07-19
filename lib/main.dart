import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(title: "Form", home: SimpleForm()));
}

class SimpleForm extends StatefulWidget {
  const SimpleForm({super.key});

  @override
  State<SimpleForm> createState() => _SimpleFormState();
}

class _SimpleFormState extends State<SimpleForm> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = "shree";
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  // bool get mounted {
  //   super.mounted;
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  String name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form"),
      ),
      body: Container(
        margin: EdgeInsets.all(30.0),
        child: Column(children: <Widget>[
          TextField(
            onSubmitted: (String userName) {
              setState(() {
                name = userName;
              });
            },
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Name is $name",
            style: TextStyle(fontSize: 25.0),
          ),
        ]),
      ),
    );
  }
}
