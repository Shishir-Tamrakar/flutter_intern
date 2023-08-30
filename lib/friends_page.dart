import 'package:flutter/material.dart';
import 'Model/user_list.dart';
import 'Model/user_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'Model/user_friend_list.dart';
import 'dart:math';

class FriendsPage extends StatefulWidget {
  final int userID;
  const FriendsPage({super.key, required this.userID});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  List<User> users = [];
  List<UserDetail> userDetails = [];
  List<UserFriendList> userFriends = [];
  User? requestSenderUser;
  User? loggedUser;
  UserDetail? loggedUserDetail;
  UserFriendList? loggedUserFriendsDetail;
  // UserFriendList? userRequestAcceptDetail;
  int generateRandomId() {
    Random random = Random();
    return random.nextInt(999);
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

    String? userID = prefs.getString('friendProfileId');
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

    String? userID = prefs.getString('friendProfileId');
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

  Future<List<String>> getRequestSenderUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userID = prefs.getString('userID');
    if (userID != null) {
      try {
        requestSenderUser =
            users.firstWhere((user) => user.id.toString() == userID);
      } catch (e) {
        print("error ${e}");
      }
      // return dataList;
    } else {
      requestSenderUser;
    }
    return []; // Return an empty list if no data is found in SharedPreferences
  }

  Future<List<String>> getUserFriendsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('userFriends');
    if (jsonData != null) {
      try {
        final decodedData = json.decode(jsonData) as List<dynamic>;
        // List<String> dataList =
        //     decodedData.map((item) => item.toString()).toList();
        setState(() {
          userFriends =
              decodedData.map((e) => UserFriendList.fromJson(e)).toList();
        });
      } catch (e) {
        print("error ${e}");
      }
      // return dataList;
    } else {
      userFriends = [];
    }
    return []; // Return an empty list if no data is found in SharedPreferences
  }

  Future<List<String>> getLoggedUserFriendsData() async {
    try {
      loggedUserFriendsDetail = userFriends.firstWhere((user) =>
          user.friendId == loggedUser!.id &&
          user.userId == requestSenderUser!.id &&
          user.requestedBy == requestSenderUser!.id);
    } catch (e) {
      print("error ${e}");
    }
    // return dataList;
    return []; // Return an empty list if no data is found in SharedPreferences
  }

  // Future<List<String>> getuserRequestAccept() async {
  //   try {
  //     userRequestAcceptDetail = userFriends.firstWhere((user) =>
  //         user.friendId == requestSenderUser!.id &&
  //         user.userId == loggedUser!.id &&
  //         user.requestedBy == loggedUser!.id);
  //   } catch (e) {
  //     print("errorrrr ${e}");
  //   }
  //   // return dataList;
  //   return []; // Return an empty list if no data is found in SharedPreferences
  // }

  Future<void> sendOrCancelRequest(int id) async {
    if (loggedUserFriendsDetail == null) {
      await sendFriendRequest(id);
    } else if (loggedUserFriendsDetail != null &&
        loggedUserFriendsDetail!.hasNewRequestAccepted == false) {
      await cancelFriendRequest();
    } else if (loggedUserFriendsDetail != null &&
        loggedUserFriendsDetail!.hasNewRequestAccepted == true) {
      return;
    }
  }

  Widget sendOrCancelText() {
    if (loggedUserFriendsDetail != null &&
        loggedUserFriendsDetail!.hasNewRequestAccepted == true) {
      return const Text("Accepted");
    } else if (loggedUserFriendsDetail == null) {
      return const Text("Add Friend");
    } else if (loggedUserFriendsDetail != null &&
        loggedUserFriendsDetail!.hasNewRequestAccepted == false) {
      return const Text("Cancel Request");
    }
    return Text(" ");
  }

  Widget sendOrCancelIcon() {
    if (loggedUserFriendsDetail == null) {
      return const Icon(Icons.person_add);
    } else if (loggedUserFriendsDetail != null &&
        loggedUserFriendsDetail!.hasNewRequestAccepted == false) {
      return const Icon(Icons.cancel);
    } else if (loggedUserFriendsDetail != null &&
        loggedUserFriendsDetail!.hasNewRequestAccepted == true) {
      return const Icon(Icons.check);
    }
    return Text(" ");
  }

  Future<void> sendFriendRequest(int id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final jsonString = sharedPreferences.getString('userFriends');
    if (jsonString != null) {
      try {
        final jsonData = jsonDecode(jsonString);
        if (jsonData is List<dynamic>) {
          userFriends =
              jsonData.map((json) => UserFriendList.fromJson(json)).toList();
        } else if (jsonData is Map<String, dynamic>) {
          userFriends.add(UserFriendList.fromJson(jsonData));
        }
      } catch (e) {
        print("Error data: $e");
      }
    }
    userFriends.add(UserFriendList(
      id: id,
      userId: requestSenderUser!.id,
      friendId: loggedUser!.id,
      requestedBy: requestSenderUser!.id,
      createdAt: DateTime.now().toString(),
      hasNewRequest: true,
      hasNewRequestAccepted: false,
      hasRemoved: false,
    ));
    print(userFriends.length);
    List<Map<String, dynamic>> jsonDataList =
        userFriends.map((cv) => cv.toJson()).toList();
    print(jsonDataList);
    String jsonData = json.encode(jsonDataList);
    sharedPreferences.setString('userFriends', jsonData);
    loadInitialData();
  }

  Future<void> cancelFriendRequest() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // final jsonString = prefs.getString('userFriends');
      // if (jsonString != null) {
      //   try {
      //     final jsonData = jsonDecode(jsonString);
      //     if (jsonData is List<dynamic>) {
      //       userFriends =
      //           jsonData.map((json) => UserFriendList.fromJson(json)).toList();
      //     } else if (jsonData is Map<String, dynamic>) {
      //       userFriends.add(UserFriendList.fromJson(jsonData));
      //     }
      //   } catch (e) {
      //     print("Error data: $e");
      //   }
      // }
      // setState(() {
      //   userFriends.remove(loggedUserFriendsDetail);
      // });

      int indextToRemove = userFriends.indexWhere((post) =>
          post.userId == requestSenderUser!.id &&
          post.requestedBy == requestSenderUser!.id &&
          post.friendId == loggedUser!.id);
      print(indextToRemove);
      setState(() {
        if (indextToRemove != -1) {
          // List<int> likedBy =
          //     userFriends[indextToUpdate].postLikedBy;
          userFriends.removeAt(indextToRemove);
        } else {
          print('FriendList with User not Found.');
        }
      });

      List<Map<String, dynamic>> jsonDataList =
          userFriends.map((cv) => cv.toJson()).toList();
      print(jsonDataList);
      String jsonDataString = json.encode(jsonDataList);
      prefs.setString('userFriends', jsonDataString);
      loadInitialData();
      // await getUserFriendsData();
      // await getLoggedUserFriendsData();
      setState(() {});
    } catch (e) {
      print("error ${e}");
    }
    // return dataList;

    return; // Return an empty
  }

  final double coverHeight = 150;
  final double profileHeight = 110;

  @override
  void initState() {
    loadInitialData();
    // TODO: implement initState
    super.initState();
  }

  void loadInitialData() async {
    await getUserData();
    await getUserDetailsData();
    await getLoggedUserData();
    await getLoggedUserDetailsData();
    // await getuserRequestAccept();
    await getRequestSenderUserData();
    await getUserFriendsData();
    await getLoggedUserFriendsData();
  }

  @override
  Widget build(BuildContext context) {
    final top = coverHeight - profileHeight / 2;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
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
                        child: loggedUserDetail!.coverImage.path == " "
                            ? Image.asset("assets/defaultcoverpic.jpg")
                            : Image.file(
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
                          child: loggedUserDetail!.profileImage.path != " "
                              ? CircleAvatar(
                                  radius: profileHeight / 2,
                                  backgroundColor: Colors.grey.shade800,
                                  backgroundImage:
                                      FileImage(loggedUserDetail!.profileImage),
                                )
                              : CircleAvatar(
                                  radius: profileHeight / 2,
                                  backgroundColor: Colors.grey.shade800,
                                  backgroundImage:
                                      AssetImage("assets/defaultprofpic.jpg"),
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
                        onPressed: () async {
                          int id = generateRandomId();
                          sendOrCancelRequest(id);
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                        icon: sendOrCancelIcon(),
                        label: sendOrCancelText()),
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
                        backgroundColor:
                            const Color.fromARGB(255, 216, 216, 216),
                      ),
                      icon: Icon(
                        Icons.message_outlined,
                        color: Colors.black,
                      ),
                      label: Text(
                        "Message",
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
      )),
    );
  }
}
