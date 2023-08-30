import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepal_social_app/cubit/bottom_nav_bar_cubit.dart';
import 'package:nepal_social_app/drawer.dart';
import 'package:nepal_social_app/home_page.dart';
import 'package:nepal_social_app/search.dart';
import 'package:nepal_social_app/user_friends_page.dart';
import 'package:nepal_social_app/user_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'Model/user_list.dart';
import 'Model/user_detail.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<User> users = [];
  List<UserDetail> userDetails = [];
  User? loggedUser;
  UserDetail? loggedUserDetail;
  final List<Widget> _pages = [HomePage(), UserPage(), UserFriendPage()];
  final scaffoldKey = GlobalKey<ScaffoldState>();
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
    return BlocBuilder<BottomNavBarCubit, int>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Social App',
              style: TextStyle(color: Color.fromARGB(255, 68, 79, 88)),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    showSearch(
                        context: context,
                        delegate: CustomSearchDelegate(
                            users: users, userDetails: userDetails));
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ))
            ],
            leading: Builder(builder: (BuildContext context) {
              return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(
                    Icons.menu_open,
                    color: Colors.black,
                  ));
            }),
          ),
          body: _pages[state],
          drawer: DrawerPage(),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state,
            onTap: (index) {
              BlocProvider.of<BottomNavBarCubit>(context).index(index);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.verified_user), label: 'UserPage'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.people), label: 'Friends'),
            ],
          ),
        );
      },
    );
  }
}
