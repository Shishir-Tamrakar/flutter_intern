import 'package:flutter/material.dart';
import 'package:nepal_social_app/feed_page.dart';

import 'Model/user_list.dart';
import 'Model/user_detail.dart';
import 'Model/user_post.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:math';

class CreatePost extends StatefulWidget {
  final User? user;
  final UserDetail? userDetail;
  const CreatePost({super.key, required this.user, required this.userDetail});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  TextEditingController description = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<UserPost> userPosts = [];
  File? postImage;
  int generateRandomId() {
    Random random = Random();
    return random.nextInt(999);
  }

  _getFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        postImage = File(pickedFile.path);
      });
    }
  }

  Future<void> postUserData(int id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final jsonString = sharedPreferences.getString('userPosts');
    if (jsonString != null) {
      try {
        final jsonData = jsonDecode(jsonString);
        if (jsonData is List<dynamic>) {
          userPosts = jsonData.map((json) => UserPost.fromJson(json)).toList();
        } else if (jsonData is Map<String, dynamic>) {
          userPosts.add(UserPost.fromJson(jsonData));
        }
      } catch (e) {
        print("Error data: $e");
      }
    }
    userPosts.add(UserPost(
      postId: id,
      userId: widget.user!.id,
      description: description.text,
      title: "",
      image: postImage!,
      postLikedBy: [],
      createdAt: DateTime.now().toString(),
    ));

    List<Map<String, dynamic>> jsonDataList =
        userPosts.map((cv) => cv.toJson()).toList();
    String jsonData = json.encode(jsonDataList);
    sharedPreferences.setString('userPosts', jsonData);
  }

  @override
  void initState() {
    description.text = "";
    //
    //TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Post",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  // final int id = 1;
                  // final String username = fullName.text;
                  // final String email = emailController.text;
                  // final String password =
                  //     passwordController.text;
                  int id = generateRandomId();
                  await postUserData(id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Post Submitted'),
                        backgroundColor: Colors.green),
                  );
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => FeedPage()),
                      (Route<dynamic> route) => false);
                }
              },
              style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.0))),
              child: Text(
                "Post",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(
              thickness: 1,
              color: const Color.fromARGB(255, 214, 212, 212),
            ),
            Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25.0,
                          backgroundImage:
                              FileImage(widget.userDetail!.profileImage),
                        ),
                        SizedBox(
                          width: 25.0,
                        ),
                        Text(
                          widget.user!.username,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              fontFamily: "WorkSans"),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    postImage == null
                        ? Container()
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.file(
                              postImage!,
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: 400.0,
                      padding: EdgeInsets.all(10.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Cannot be empty";
                          }
                          return null;
                        },
                        maxLines: null,
                        controller: description,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Whats on your mind?'),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    ListTile(
                      leading: IconButton(
                        onPressed: () {
                          _getFromGallery();
                        },
                        icon: Icon(
                          Icons.image_search,
                          size: 40.0,
                          color: Colors.green,
                        ),
                      ),
                      title: Text("Add photo"),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
