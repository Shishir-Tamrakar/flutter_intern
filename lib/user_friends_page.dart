import 'package:flutter/material.dart';
import 'Model/user_friend_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'Model/user_list.dart';
import 'Model/user_detail.dart';

class UserFriendPage extends StatefulWidget {
  const UserFriendPage({super.key});

  @override
  State<UserFriendPage> createState() => _UserFriendPageState();
}

class _UserFriendPageState extends State<UserFriendPage> {
  List<UserFriendList> allUserFriends = [];
  List<UserFriendList> userFriends = [];
  List<User> users = [];
  List<User> friendData = [];
  List<UserDetail> userDetails = [];
  List<UserDetail> friendDetailData = [];
  User? loggedUser;
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

  Future<List<String>> getAllUserFriendsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('userFriends');
    if (jsonData != null) {
      try {
        final decodedData = json.decode(jsonData) as List<dynamic>;
        // List<String> dataList =
        //     decodedData.map((item) => item.toString()).toList();
        setState(() {
          allUserFriends =
              decodedData.map((e) => UserFriendList.fromJson(e)).toList();
        });
      } catch (e) {
        print("error ${e}");
      }
      // return dataList;
    } else {
      allUserFriends = [];
    }
    return []; // Return an empty list if no data is found in SharedPreferences
  }

  Future<List<String>> getFriendRequests() async {
    for (var userFriend in allUserFriends) {
      if (userFriend.friendId == loggedUser!.id &&
          userFriend.hasNewRequestAccepted == false &&
          userFriend.hasNewRequest == true) {
        userFriends.add(userFriend);
      }
    }
    print(userFriends.length);
    return [];
  }

  Future<List<String>> getUserFriendsData() async {
    for (var userFriendd in userFriends) {
      for (var user in users) {
        if (userFriendd.userId == user.id) {
          friendData.add(user);
        }
      }
    }

    return [];
  }

  Future<List<String>> getUserFriendsDetailData() async {
    for (var userFriendd in userFriends) {
      for (var userDetail in userDetails) {
        if (userFriendd.userId == userDetail.id) {
          friendDetailData.add(userDetail);
        }
      }
    }

    return [];
  }

  Future<void> confirmFriendRequest(int friendId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int indexToUpdate = allUserFriends.indexWhere(
          (all) => all.friendId == loggedUser!.id && all.userId == friendId);
      if (indexToUpdate != -1) {
        allUserFriends[indexToUpdate].hasNewRequestAccepted = true;
      } else {
        print("Friend request not found");
      }

      List<Map<String, dynamic>> jsonDataList =
          allUserFriends.map((cv) => cv.toJson()).toList();
      print(jsonDataList);
      String jsonDataString = json.encode(jsonDataList);
      prefs.setString('userFriends', jsonDataString);
      // loadInitialData();
      setState(() {});
    } catch (e) {
      print(e);
    }
    return;
  }

  Future<void> cancelFriendRequest(int friendId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int indexToUpdate = allUserFriends.indexWhere(
          (all) => all.friendId == loggedUser!.id && all.userId == friendId);
      if (indexToUpdate != -1) {
        allUserFriends.removeAt(indexToUpdate);
      } else {
        print("Friend request not found");
      }

      List<Map<String, dynamic>> jsonDataList =
          allUserFriends.map((cv) => cv.toJson()).toList();
      print(jsonDataList);
      String jsonDataString = json.encode(jsonDataList);
      prefs.setString('userFriends', jsonDataString);
      // loadInitialData();
      setState(() {});
    } catch (e) {
      print(e);
    }
    return;
  }

  void loadInitialData() async {
    await getUserData();
    await getUserDetailsData();
    await getLoggedUserData();
    await getAllUserFriendsData();
    await getFriendRequests();
    await getUserFriendsData();
    await getUserFriendsDetailData();
  }

  @override
  void initState() {
    loadInitialData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Divider(
            color: const Color.fromARGB(255, 224, 224, 224),
            thickness: 1,
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Friend Requests",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "WorkSans",
                          fontSize: 18.0),
                    ),
                    SizedBox(
                      width: 170.0,
                    ),
                    Text(
                      "See all",
                      style: TextStyle(color: Colors.blue),
                    )
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                friendData.isEmpty
                    ? Text("No Requests")
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        reverse: true,
                        itemCount: friendData.length,
                        itemBuilder: (BuildContext context, index) {
                          final userFriend = friendData[index];
                          final userFriendDetail = friendDetailData[index];
                          return Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 35.0,
                                    backgroundColor: Colors.grey.shade800,
                                    backgroundImage: FileImage(
                                        userFriendDetail.profileImage),
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        userFriend.username,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Row(
                                        children: [
                                          ElevatedButton(
                                              onPressed: () async {
                                                await confirmFriendRequest(
                                                    userFriend.id);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 63, 66, 73)),
                                              child: Text("Confirm")),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          ElevatedButton(
                                              onPressed: () async {
                                                await cancelFriendRequest(
                                                    userFriend.id);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 63, 66, 73)),
                                              child: Text("Delete"))
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Divider(
                                color: const Color.fromARGB(255, 224, 224, 224),
                                thickness: 1,
                              )
                            ],
                          );
                        }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
