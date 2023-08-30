import 'package:flutter/material.dart';
import 'Model/user_detail.dart';
import 'Model/user_list.dart';
import 'friends_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomSearchDelegate extends SearchDelegate {
  List<User> users;
  List<UserDetail> userDetails;
  CustomSearchDelegate({required this.users, required this.userDetails});
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    List<User> allUser = users;
    List<UserDetail> allUserDetail = userDetails;
    List<User> user = (query.isEmpty)
        ? []
        : allUser
            .where((element) =>
                element.username.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
    List<UserDetail> userDetail = [];
    for (var userss in user) {
      for (var userDetaill in allUserDetail) {
        if (userss.id == userDetaill.id) {
          userDetail.add(userDetaill);
        }
      }
    }
    return ListView.builder(
        padding: EdgeInsets.only(top: 20.0),
        itemCount: user.length,
        itemBuilder: (BuildContext context, index) {
          User users = user[index];
          UserDetail userDetails = userDetail[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: ListTile(
              leading: userDetails.profileImage.path == " "
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Image.asset("assets/defaultprofpic.jpg"))
                  : CircleAvatar(
                      radius: 30,
                      backgroundImage: FileImage(userDetails.profileImage),
                    ),
              title: Text(users.username),
              subtitle: Divider(
                thickness: 1,
                color: Colors.grey,
              ),
            ),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<User> allUser = users;
    List<UserDetail> allUserDetail = userDetails;
    List<User>? user = (query.isEmpty)
        ? []
        : allUser
            .where((element) =>
                element.username.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
    List<UserDetail> userDetail = [];
    for (var userss in user) {
      for (var userDetaill in allUserDetail) {
        if (userss.id == userDetaill.id) {
          userDetail.add(userDetaill);
        }
      }
    }
    return ListView.builder(
        padding: EdgeInsets.only(top: 20.0),
        itemCount: user.length,
        itemBuilder: (BuildContext context, index) {
          User? users = user[index];
          UserDetail? userDetails = userDetail[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 15.0),
            child: ListTile(
              leading: userDetails.profileImage.path == " "
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Image.asset("assets/defaultprofpic.jpg"))
                  : CircleAvatar(
                      radius: 30,
                      backgroundImage: FileImage(userDetails.profileImage),
                    ),
              title: Text(users.username),
              // subtitle: Divider(
              //   thickness: 1,
              //   color: Colors.grey,
              // ),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('friendProfileId', users.id.toString());
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FriendsPage(
                              userID: users.id,
                            )));
              },
            ),
          );
        });
  }
}
