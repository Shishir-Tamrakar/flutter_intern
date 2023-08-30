import 'package:flutter/material.dart';
import 'package:nepal_social_app/create_post_page.dart';
import 'Model/user_list.dart';
import 'Model/user_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'Model/user_post.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> users = [];
  List<UserDetail> userDetails = [];
  List<UserPost> userPosts = [];

  User? loggedUser;
  UserDetail? loggedUserDetail;
  User? postUser;
  UserDetail? postUserDetail;
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

  Future<List<String>> getPostData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('userPosts');
    if (jsonData != null) {
      try {
        final decodedData = json.decode(jsonData) as List<dynamic>;
        // List<String> dataList =
        //     decodedData.map((item) => item.toString()).toList();
        setState(() {
          userPosts = decodedData.map((e) => UserPost.fromJson(e)).toList();
        });
      } catch (e) {
        print("error ${e}");
      }
      // return dataList;
    } else {
      userPosts = [];
    }
    return []; // Return an empty list if no data is found in SharedPreferences
  }

  Future<void> likePost(
      int postIdToUpdate, int indexToUpdate, int userIdToAddOrRemove) async {
    setState(() {
      if (indexToUpdate != -1) {
        List<int> likedBy = userPosts[indexToUpdate].postLikedBy;
        if (likedBy.contains(userIdToAddOrRemove)) {
          likedBy.remove(userIdToAddOrRemove);
        } else {
          likedBy.add(userIdToAddOrRemove);
        }
      } else {
        print('UserPost with postId $postIdToUpdate not found.');
      }
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String updatedPosts = jsonEncode(userPosts);
    prefs.setString("userPosts", updatedPosts);
    getPostData();
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
    getPostData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Divider(
            thickness: 1,
            color: const Color.fromARGB(255, 224, 224, 224),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              children: [
                loggedUserDetail == null
                    ? CircleAvatar(
                        backgroundColor: Colors.grey.shade800,
                      )
                    : CircleAvatar(
                        radius: 20.0,
                        backgroundColor: Colors.grey.shade800,
                        backgroundImage:
                            FileImage(loggedUserDetail!.profileImage),
                      ),
                const SizedBox(
                  width: 13.0,
                ),
                Container(
                    height: 37.0,
                    width: 260.0,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromARGB(255, 167, 165, 165)),
                        borderRadius: BorderRadius.circular(40.0)),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreatePost(
                                      user: loggedUser,
                                      userDetail: loggedUserDetail,
                                    )));
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0))),
                      child: Text(
                        "Whats on your mind?",
                        style:
                            TextStyle(color: Color.fromARGB(255, 68, 67, 67)),
                      ),
                    )),
                SizedBox(
                  width: 10.0,
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.photo,
                      color: Colors.green,
                      size: 30.0,
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Divider(
            color: Color.fromARGB(255, 214, 214, 214),
            thickness: 9.0,
          ),
          ListView.builder(
              shrinkWrap: true,
              reverse: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: userPosts.length,
              itemBuilder: (BuildContext context, index) {
                final userPost = userPosts[index];
                postUser =
                    users.firstWhere((user) => user.id == userPost.userId);
                postUserDetail = userDetails.firstWhere(
                    (userDetail) => userDetail.id == userPost.userId);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: postUserDetail == null
                          ? CircleAvatar()
                          : CircleAvatar(
                              radius: 20.0,
                              backgroundColor: Colors.grey.shade800,
                              backgroundImage:
                                  FileImage(postUserDetail!.profileImage),
                            ),
                      title: postUser == null
                          ? Text("asd")
                          : Text(
                              postUser!.username,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                      subtitle: Text(userPost.createdAt),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(userPost.description),
                    ),
                    SizedBox(
                      height: 13.0,
                    ),
                    ClipRRect(
                      child: Image.file(
                        userPost.image,
                        height: 300.0,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.thumb_up_off_alt,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            "${userPost.postLikedBy.length}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 35.0),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              int postIdToUpdate = userPost.postId;
                              int userIdToAddOrRemove =
                                  loggedUser == null ? -1 : loggedUser!.id;
                              int indextToUpdate = userPosts.indexWhere(
                                  (post) => post.postId == postIdToUpdate);
                              likePost(postIdToUpdate, indextToUpdate,
                                  userIdToAddOrRemove);
                            },
                            icon: Icon(
                              Icons.thumb_up,
                              color:
                                  userPost.postLikedBy.contains(loggedUser!.id)
                                      ? Colors.blue
                                      : Colors.grey,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            "Like",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 40.0,
                          ),
                          Icon(
                            Icons.messenger_outline_sharp,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            "Comment",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Divider(
                      color: Color.fromARGB(255, 214, 214, 214),
                      thickness: 9.0,
                    ),
                  ],
                );
              }),
        ],
      ),
    );
  }
}
