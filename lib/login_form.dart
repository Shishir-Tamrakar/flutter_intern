import 'package:flutter/material.dart';
import 'package:nepal_social_app/register_form.dart';
import 'feed_page.dart';
import 'model/user_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'model/user_detail.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  List<User> users = [];
  List<UserDetail> userDetails = [];
  bool passwordVisible = false;
  bool isValidEmail(String input) {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(input);
  }

  Future<void> createAlertDialog(BuildContext context,
      {String? message}) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Error!!",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red),
            ),
            content: Text(message!),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Okay',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Future<void> readUserData() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final userString = sharedPreferences.getString('users');
      if (userString == null) {
        String jsonString = await rootBundle.loadString('assets/users.json');
        final jsonData = jsonDecode(jsonString);
        if (jsonData is List<dynamic>) {
          users = jsonData.map((json) => User.fromJson(json)).toList();
        } else if (jsonData is Map<String, dynamic>) {
          users.add(User.fromJson(jsonData));
        }
        List<Map<String, dynamic>> userJsonList =
            users.map((cv) => cv.toJson()).toList();
        String userJsonString = json.encode(userJsonList);
        sharedPreferences.setString('users', userJsonString);
      }
    } catch (e) {
      print(
          'Error reading JSON from assets or storing in shared preferences: $e');
    }
  }

  Future<void> readUserDetailsData() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final userString = sharedPreferences.getString('userDetails');
      if (userString == null) {
        String jsonString =
            await rootBundle.loadString('assets/user_details.json');
        final jsonData = jsonDecode(jsonString);
        if (jsonData is List<dynamic>) {
          userDetails =
              jsonData.map((json) => UserDetail.fromJson(json)).toList();
        } else if (jsonData is Map<String, dynamic>) {
          userDetails.add(UserDetail.fromJson(jsonData));
        }
        List<Map<String, dynamic>> userJsonList =
            userDetails.map((cv) => cv.toJson()).toList();
        String userJsonString = json.encode(userJsonList);
        sharedPreferences.setString('userDetails', userJsonString);
      }
    } catch (e) {
      print(
          'Error reading JSON from assets or storing in shared preferences: $e');
    }
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

  void _loginUser(String email, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => FeedPage()));
      User user = users.firstWhere(
          (user) => user.email == email && user.password == password);

      // User is logged in.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login Successful')),
      );
      sharedPreferences.setString('userID', user.id.toString());
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => FeedPage()),
          (Route<dynamic> route) => false);
      print('User logged in successfully!');
      return;
    } catch (e) {
      await createAlertDialog(context,
          message: "Email and password does not match");
      return;
    }
  }

  @override
  void initState() {
    emailController.text = "";
    passwordController.text = "";
    readUserData();
    readUserDetailsData();
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Stack(children: [
                ClipRect(
                  child: Image.asset("assets/loginImage.PNG"),
                ),
                Positioned(
                  top: 180.0,
                  left: 60.0,
                  child: Text(
                    "Welcome\n Back,",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 42.0,
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Positioned(
                  top: 360.0,
                  left: 120.0,
                  child: Text(
                    "Connect to the world",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        fontFamily: 'workSans'),
                  ),
                )
              ]),
              SizedBox(height: 50.0),
              // Text(
              //   "Login",
              //   style: TextStyle(
              //       color: Colors.black,
              //       fontWeight: FontWeight.bold,
              //       fontSize: 30.0,
              //       fontFamily: 'workSans'),
              // ),
              // SizedBox(
              //   height: 20.0,
              // ),
              Container(
                width: 350.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(196, 135, 198, .4),
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      ),
                    ]),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Colors.grey))),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Cannot be empty";
                          } else if (!isValidEmail(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        controller: emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Colors.grey))),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Cannot be empty";
                          }
                          return null;
                        },
                        controller: passwordController,
                        obscureText: !passwordVisible,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.grey),
                          suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },
                              // onLongPressUp: () {
                              //   setState(() {
                              //     passwordVisible = false;
                              //   });
                              // },
                              child: Icon(
                                passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              SizedBox(
                width: 140.0,
                height: 50.0,
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // _formKey.currentState!.save();
                        _loginUser(
                            emailController.text, passwordController.text);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        backgroundColor: Color.fromARGB(255, 63, 66, 73)),
                    child: Text("Login")),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                'Forgot Password?',
                style: TextStyle(
                    color: Colors.blueAccent, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("New to Social App? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterForm()));
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
