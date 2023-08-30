import 'package:flutter/material.dart';
import 'Model/user_list.dart';
import 'Model/user_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<User> users = [];
  List<UserDetail> userDetails = [];
  User? loggedUser;
  UserDetail? loggedUserDetail;

  Future<List<String>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('users');
    if (jsonData != null) {
      try {
        final decodedData = json.decode(jsonData) as List<dynamic>;
        // List<String> dataList =
        //     decodedData.map((item) => item.toString()).toList();
        setState(() {
          users = decodedData.map((e) => User.fromJson(e)).toList();
        });
      } catch (e) {
        print("error ${e}");
      }
      // return dataList;
    } else {
      users = [];
    }
    return []; // Return an empty list if no data is found in SharedPreferences
  }

  Future<List<String>> getUserDetailsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('userDetails');
    if (jsonData != null) {
      try {
        final decodedData = json.decode(jsonData) as List<dynamic>;
        // List<String> dataList =
        //     decodedData.map((item) => item.toString()).toList();
        setState(() {
          userDetails = decodedData.map((e) => UserDetail.fromJson(e)).toList();
        });
      } catch (e) {
        print("error ${e}");
      }
      // return dataList;
    } else {
      userDetails = [];
    }
    return []; // Return an empty list if no data is found in SharedPreferences
  }

  Future<List<String>> getLoggedUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userID = prefs.getString('userID');
    if (userID != null) {
      try {
        loggedUser = users.firstWhere((user) => user.id.toString() == userID);
      } catch (e) {
        print("error ${e}");
      }
      // return dataList;
    } else {
      loggedUser;
    }
    return []; // Return an empty list if no data is found in SharedPreferences
  }

  Future<List<String>> getLoggedUserDetailsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userID = prefs.getString('userID');
    if (userID != null) {
      try {
        loggedUserDetail =
            userDetails.firstWhere((user) => user.id.toString() == userID);
      } catch (e) {
        print("error ${e}");
      }
      // return dataList;
    } else {
      loggedUserDetail;
    }
    return []; // Return an empty list if no data is found in SharedPreferences
  }

  final double coverHeight = 150;
  final double profileHeight = 110;

  @override
  void initState() {
    getUserData();
    getUserDetailsData();
    getLoggedUserData();
    getLoggedUserDetailsData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final top = coverHeight - profileHeight / 2;

    return SingleChildScrollView(
        child: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          loggedUserDetail == null
              ? Container()
              : Stack(
                  clipBehavior: Clip.none,
                  // alignment: Alignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 70.0),
                      color: Colors.grey,
                      child: Image.file(
                        loggedUserDetail!.coverImage,
                        width: double.infinity,
                        height: coverHeight,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: top,
                      left: 15.0,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(60.0)),
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: profileHeight / 2,
                          backgroundColor: Colors.grey.shade800,
                          backgroundImage:
                              FileImage(loggedUserDetail!.profileImage),
                        ),
                      ),
                    )
                  ],
                ),
          SizedBox(
            height: 5.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: loggedUser == null
                ? Text("No details")
                : Text(
                    loggedUser!.username,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                        fontFamily: 'WorkSans'),
                  ),
          ),
          SizedBox(
            height: 3.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: loggedUser == null
                ? Text("No details")
                : Text(
                    loggedUser!.email,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0,
                        fontFamily: 'WorkSans'),
                  ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Row(
              children: [
                Container(
                  width: 170.0,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                    icon: Icon(Icons.person_pin_circle),
                    label: Text("View Friends"),
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                Container(
                  width: 170.0,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      backgroundColor: const Color.fromARGB(255, 216, 216, 216),
                    ),
                    icon: Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                    label: Text(
                      "Edit Profile",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(19.0),
            child: Container(
              padding: EdgeInsets.all(15.0),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color.fromARGB(255, 201, 224, 243)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Summary",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: 'WorkSans'),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  loggedUserDetail == null
                      ? Text("Your summary will be shown here")
                      : Text(loggedUserDetail!.summary),
                ],
              ),
            ),
          ),
          Divider(
            color: Color.fromARGB(255, 214, 214, 214),
            thickness: 9.0,
          ),
          Padding(
            padding: EdgeInsets.all(19.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Basic Info",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21.0,
                      fontFamily: 'WorkSans'),
                ),
                ListTile(
                  leading: Icon(Icons.account_box, size: 40),
                  title: loggedUserDetail == null
                      ? Text("Your Gender")
                      : Text(
                          loggedUserDetail!.gender,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                  subtitle: Text("Gender"),
                ),
                Divider(
                  thickness: 2,
                  indent: 70,
                ),
                ListTile(
                  leading: Icon(Icons.cake, size: 40),
                  title: loggedUserDetail == null
                      ? Text("Your DOB")
                      : Text(
                          loggedUserDetail!.dob,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                  subtitle: Text("Date of Birth"),
                ),
                Divider(
                  thickness: 2,
                  indent: 70,
                ),
                ListTile(
                  leading: Icon(Icons.messenger, size: 35),
                  title: Text(
                    "English, Nepali, Hindi",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("Languages"),
                ),
                Divider(
                  thickness: 2,
                  indent: 70,
                ),
                ListTile(
                  leading: Icon(Icons.sports_basketball, size: 35),
                  title: Text(
                    "Reading, Studing, Basketball",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("Hobbies"),
                ),
                Divider(
                  thickness: 2,
                ),
                Text(
                  "Contact Info",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21.0,
                      fontFamily: 'WorkSans'),
                ),
                ListTile(
                  leading: Icon(Icons.mobile_friendly, size: 40),
                  title: loggedUserDetail == null
                      ? Text("Enter phone no.")
                      : Text(
                          loggedUserDetail!.mobileNumber,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                  subtitle: Text("Mobile No."),
                ),
                Divider(
                  thickness: 2,
                  indent: 70,
                ),
                ListTile(
                  leading: Icon(Icons.facebook, size: 40),
                  title: loggedUserDetail == null
                      ? Text("Social link")
                      : Text(
                          loggedUserDetail!.socialLinks,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                  subtitle: Text("Facebook link"),
                ),
                Divider(
                  thickness: 2,
                ),
                Text(
                  "Relationship",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21.0,
                      fontFamily: 'WorkSans'),
                ),
                ListTile(
                  leading: Icon(Icons.family_restroom, size: 40),
                  title: loggedUserDetail == null
                      ? Text("Marital status")
                      : Text(
                          loggedUserDetail!.maritalStatus,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                  subtitle: Text("public"),
                ),
                Divider(
                  thickness: 2,
                ),
              ],
            ),
          ),
          Divider(
            color: Color.fromARGB(255, 214, 214, 214),
            thickness: 9.0,
          ),
          Padding(
            padding: EdgeInsets.all(19.0),
            child: Column(
              children: [
                Row(children: [
                  Text(
                    "Work Experience",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 21.0,
                        fontFamily: 'WorkSans'),
                  ),
                  SizedBox(
                    width: 120.0,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.add,
                        size: 30.0,
                      ))
                ]),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.work,
                      size: 40.0,
                    ),
                    SizedBox(
                      width: 50.0,
                    ),
                    Column(
                      children: [
                        Text("Flutter Developer",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'WorkSans')),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text("Ambission Guru"),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: [
                            Text('2023-05-21'),
                            Text(' to '),
                            Text('2024-06-21')
                          ],
                        )
                      ],
                    )
                  ],
                ),
                Divider(
                  thickness: 2,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.work,
                      size: 40.0,
                    ),
                    SizedBox(
                      width: 50.0,
                    ),
                    Column(
                      children: [
                        Text("Web Developer",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'WorkSans')),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text("F1 Soft"),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: [
                            Text('2023-05-21'),
                            Text(' to '),
                            Text('2024-06-21')
                          ],
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Divider(
            color: Color.fromARGB(255, 214, 214, 214),
            thickness: 9.0,
          ),
          Padding(
            padding: EdgeInsets.all(19.0),
            child: Column(
              children: [
                Row(children: [
                  Text(
                    "Education",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 21.0,
                        fontFamily: 'WorkSans'),
                  ),
                  SizedBox(
                    width: 190.0,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.add,
                        size: 30.0,
                      ))
                ]),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.menu_book_sharp,
                      size: 40.0,
                    ),
                    SizedBox(
                      width: 50.0,
                    ),
                    Column(
                      children: [
                        Text("Islington College",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'WorkSans')),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text("Bachelors in Computing"),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: [
                            Text('2023-05-21'),
                            Text(' to '),
                            Text('2024-06-21')
                          ],
                        )
                      ],
                    )
                  ],
                ),
                Divider(
                  thickness: 2,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.menu_book,
                      size: 40.0,
                    ),
                    SizedBox(
                      width: 50.0,
                    ),
                    Column(
                      children: [
                        Text("DAV",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'WorkSans')),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text("+2"),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: [
                            Text('2023-05-21'),
                            Text(' to '),
                            Text('2024-06-21')
                          ],
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
