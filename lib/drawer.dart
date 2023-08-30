import 'package:flutter/material.dart';
import 'model/user_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'Model/user_detail.dart';
import 'login_form.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  List<User> users = [];
  User? loggedUser;
  List<UserDetail> userDetails = [];
  UserDetail? loggedUserDetail;
  Future logOut(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('userID');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logged Out')),
    );
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => LoginForm()),
        (Route<dynamic> route) => false);
  }

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

  @override
  void initState() {
    // TODO: implement initState
    getUserData();
    getUserDetailsData();
    getLoggedUserData();
    getLoggedUserDetailsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // backgroundColor: Color.fromARGB(255, 195, 197, 197),
      child: ListView(
        children: [
          DrawerHeader(
              padding: EdgeInsets.all(4.0),
              decoration: BoxDecoration(color: Colors.white),
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.transparent),
                accountName: loggedUser == null
                    ? Text("nodata")
                    : Text(
                        loggedUser!.username,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                accountEmail: loggedUser == null
                    ? Text("no data")
                    : Text(
                        loggedUser!.email,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold),
                      ),
                currentAccountPictureSize: Size.square(60),
                currentAccountPicture: loggedUserDetail == null
                    ? CircleAvatar(
                        backgroundImage: AssetImage("assets/snoopy.jpg"),
                      )
                    : CircleAvatar(
                        // backgroundColor: Colors.transparent,
                        backgroundImage:
                            FileImage(loggedUserDetail!.profileImage),
                        // child: Image.asset("assets/snoopy.jpg") //Text
                      ),
              )),
          Divider(
            color: Colors.black,
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("My Profile"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () {
              logOut(context);
            },
          )
        ],
      ),
    );
  }
}
