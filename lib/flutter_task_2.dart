import 'package:flutter/material.dart';
import 'dart:math';

class FlutterTaskTwo extends StatefulWidget {
  const FlutterTaskTwo({super.key});

  @override
  State<FlutterTaskTwo> createState() => _FlutterTaskTwoState();
}

class _FlutterTaskTwoState extends State<FlutterTaskTwo> {
  List<Color> colorChangeList = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.grey
  ];
  List<String> textChangeList = ["Press", "Hit", "Login", "Button"];
  List<Icon> iconChangeList = [
    Icon(Icons.access_alarm_rounded),
    Icon(Icons.account_balance),
    Icon(Icons.add_a_photo)
  ];
  List<String> imageChangeList = [
    'https://googleflutter.com/sample_image.jpg',
    'https://picsum.photos/250?image=9',
    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
  ];
  Color randomColor = Colors.black;
  Color randomFloatingColor = Colors.red;
  String randomString = "Click";
  String randomElevatedText = "Elevated Button";
  int counter = 1;
  Icon randomIcon = Icon(Icons.image_rounded);
  String randomImage =
      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg';
  var random = Random();
  void randomColorPop() {
    randomColor = colorChangeList[random.nextInt(colorChangeList.length)];
  }

  void randomFloatingColorPop() {
    randomFloatingColor =
        colorChangeList[random.nextInt(colorChangeList.length)];
  }

  void randomStringPop() {
    randomString = textChangeList[random.nextInt(textChangeList.length)];
  }

  void randomIconPop() {
    randomIcon = iconChangeList[random.nextInt(iconChangeList.length)];
  }

  void randomImagePop() {
    randomImage = imageChangeList[random.nextInt(imageChangeList.length)];
  }

  void randomElevateButton() {
    randomElevatedText = textChangeList[random.nextInt(textChangeList.length)];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              TextButton(
                onPressed: () {
                  setState(() {
                    randomColorPop();
                    randomStringPop();
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.9);
                      }
                      return null; // Use the component's default.
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)),
                  ),
                ),
                child: Text(
                  randomString,
                  style: TextStyle(fontSize: 22),
                ),
              ),
              Text(
                'data',
                style: TextStyle(color: randomColor, fontSize: 30),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        counter++;
                        randomFloatingColorPop();
                      });
                    },
                    child: Text(
                      'Count',
                      style: TextStyle(fontSize: 15),
                    ),
                    backgroundColor: randomFloatingColor,
                    hoverColor: Colors.black,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        counter = 0;
                      });
                    },
                    child: Text(
                      'Reset',
                      style: TextStyle(fontSize: 15),
                    ),
                    backgroundColor: Colors.pink,
                    hoverColor: Colors.black,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '$counter',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    randomIconPop();
                    randomImagePop();
                  });
                },
                icon: randomIcon,
                highlightColor: Colors.red,
              ),
              Image.network(
                randomImage,
                fit: BoxFit.cover,
                width: 200,
              ),
              SizedBox(
                height: 30,
              ),
              Image.asset(
                'assets/snoopy.jpg',
                fit: BoxFit.cover,
                width: 200,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      randomElevateButton();
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.5);
                        }
                        return null; // Use the component's default.
                      },
                    ),
                  ),
                  child: Text(randomElevatedText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
