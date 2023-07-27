import 'package:flutter/material.dart';
import 'form_fields.dart';

class FlutterTaskFive extends StatefulWidget {
  const FlutterTaskFive({
    super.key,
  });

  @override
  State<FlutterTaskFive> createState() => _FlutterTaskFiveState();
}

class _FlutterTaskFiveState extends State<FlutterTaskFive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CV Form'),
      ),
      body: SingleChildScrollView(
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Text(
                  'CV Form',
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
              ),
              TextFieldImplement(),
            ],
          ),
        ),
      ),
    );
  }
}
