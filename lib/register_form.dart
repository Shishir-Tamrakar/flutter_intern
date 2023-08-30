import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:flutter/services.dart';
import 'login_form.dart';
import 'package:intl/intl.dart';
import 'model/user_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:io';
import 'model/user_detail.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  List<User> users = [];
  List<UserDetail> userDetails = [];

  // File? profileImage;
  TextEditingController fullName = TextEditingController();
  TextEditingController summary = TextEditingController();
  TextEditingController dobDate = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController socialLinks = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String _gender = '';
  String _maritalStatus = '';
  File? profileImage;
  File? coverImage;
  _getFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        profileImage = File(pickedFile.path);
      });
    }
  }

  _getFromGalleryCover() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        coverImage = File(pickedFile.path);
      });
    }
  }

  bool isValidEmail(String input) {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(input);
  }

  int generateRandomId() {
    Random random = Random();
    return random.nextInt(999);
  }

  Future<void> registerUserData(int id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final jsonString = sharedPreferences.getString('users');
    if (jsonString != null) {
      try {
        final jsonData = jsonDecode(jsonString);
        if (jsonData is List<dynamic>) {
          users = jsonData.map((json) => User.fromJson(json)).toList();
        } else if (jsonData is Map<String, dynamic>) {
          users.add(User.fromJson(jsonData));
        }
      } catch (e) {
        print("Error data: $e");
      }
    }
    users.add(User(
        id: id,
        username: fullName.text,
        email: emailController.text,
        password: passwordController.text));

    List<Map<String, dynamic>> jsonDataList =
        users.map((cv) => cv.toJson()).toList();
    String jsonData = json.encode(jsonDataList);
    sharedPreferences.setString('users', jsonData);
  }

  Future<void> registerUserDetailsData(int id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final jsonString = sharedPreferences.getString('userDetails');
    if (jsonString != null) {
      try {
        final jsonData = jsonDecode(jsonString);
        if (jsonData is List<dynamic>) {
          userDetails =
              jsonData.map((json) => UserDetail.fromJson(json)).toList();
        } else if (jsonData is Map<String, dynamic>) {
          userDetails.add(UserDetail.fromJson(jsonData));
        }
      } catch (e) {
        print("Error data: $e");
      }
    }
    userDetails.add(UserDetail(
      id: id,
      profileImage: profileImage!,
      coverImage: coverImage!,
      dob: dobDate.text.toString(),
      educationFields: [],
      gender: _gender,
      hobbies: " ",
      language: [" "],
      maritalStatus: _maritalStatus,
      mobileNumber: mobileNumber.text,
      skills: [" "],
      socialLinks: socialLinks.text,
      summary: summary.text,
      workExperience: [],
    ));

    List<Map<String, dynamic>> jsonDataList =
        userDetails.map((cv) => cv.toJson()).toList();
    String jsonData = json.encode(jsonDataList);
    sharedPreferences.setString('userDetails', jsonData);
  }

  @override
  void initState() {
    fullName.text = "";
    dobDate.text = "";
    mobileNumber.text = "";
    emailController.text = "";
    passwordController.text = "";
    summary.text = "";
    socialLinks.text = "";
    _gender = "male";
    _maritalStatus = "single";

    // TODO: implement initState
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
          child: Container(
            color: Color.fromARGB(255, 79, 116, 146),
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Image.asset(
                        'assets/registerImage.jpg',
                      ),
                    ),
                    Positioned(
                      top: 190.0,
                      left: 140,
                      child: Text('Sign Up',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0)),
                    )
                  ],
                ),
                // Center(
                //   child: Text(
                //     "Sign Up",
                //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0),
                //   ),
                // ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Create an account",
                  style: TextStyle(fontSize: 15.0, color: Colors.white),
                ),
                Container(
                  padding: EdgeInsets.all(50.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Full Name:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 209, 207, 207)),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          validator: (value) {
                            final regex = RegExp(r'^[a-zA-Z\s]+$');
                            if (value == null || value.isEmpty) {
                              return "Cannot be empty";
                            } else if (value.length > 25) {
                              return 'Text must not exceed 25 characters';
                            } else if (!regex.hasMatch(value)) {
                              return 'Only alphabetic characters are allowed';
                            }
                            return null;
                          },
                          controller: fullName,
                          decoration: InputDecoration(
                              hintText: 'e.g. Stuart Little',
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 209, 207, 207)),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Text(
                              "Upload Profile Image",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 209, 207, 207)),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            MaterialButton(
                                color: Color.fromARGB(255, 209, 207, 207),
                                onPressed: () {
                                  _getFromGallery();
                                },
                                child: Text('Choose file'))
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        profileImage == null
                            ? Text(
                                "Please Enter Profile Image",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 209, 207, 207)),
                              )
                            : Image.file(profileImage!),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Text(
                              "Upload Cover Image",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 209, 207, 207)),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            MaterialButton(
                                color: Color.fromARGB(255, 209, 207, 207),
                                onPressed: () {
                                  _getFromGalleryCover();
                                },
                                child: Text('Choose file'))
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        coverImage == null
                            ? Text(
                                "Please Enter Cover Image",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 209, 207, 207)),
                              )
                            : Image.file(coverImage!),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Summary:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 209, 207, 207)),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          validator: (value) {
                            final regex = RegExp(r'^[a-zA-Z\s]+$');
                            if (value == null || value.isEmpty) {
                              return "Cannot be empty";
                            } else if (value.length > 500) {
                              return 'Text must not exceed 150 characters';
                            } else if (!regex.hasMatch(value)) {
                              return 'Only alphabetic characters are allowed';
                            }
                            return null;
                          },
                          controller: summary,
                          maxLines: 5,
                          decoration: InputDecoration(
                              hintText: 'e.g. Your Summary',
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 209, 207, 207)),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Gender:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 209, 207, 207)),
                            ),
                            Radio<String>(
                              value: 'male',
                              groupValue: _gender,
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) =>
                                      Color.fromARGB(255, 209, 207, 207)),
                              onChanged: (value) {
                                setState(() {
                                  _gender = value ?? '';
                                });
                              },
                            ),
                            Text(
                              'Male',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 209, 207, 207)),
                            ),
                            Radio<String>(
                              value: 'female',
                              groupValue: _gender,
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) =>
                                      Color.fromARGB(255, 209, 207, 207)),
                              onChanged: (value) {
                                setState(() {
                                  _gender = value ?? '';
                                });
                              },
                            ),
                            Text(
                              'Female',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 209, 207, 207)),
                            ),
                            Radio<String>(
                              value: 'other',
                              groupValue: _gender,
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) =>
                                      Color.fromARGB(255, 209, 207, 207)),
                              onChanged: (value) {
                                setState(() {
                                  _gender = value ?? '';
                                });
                              },
                            ),
                            Text(
                              'Other',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 209, 207, 207)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Date of Birth:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 209, 207, 207)),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Cannot be empty";
                            }
                            return null;
                          },
                          controller: dobDate,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(255, 209, 207, 207),
                            hintText: "e.g. 2023-02-23",
                            icon: Icon(Icons.calendar_today,
                                color: Color.fromARGB(255, 209, 207, 207)),
                          ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (pickedDate != null) {
                              print(
                                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(
                                  formattedDate); //formatted date output using intl package =>  2021-03-16
                              setState(() {
                                dobDate.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            } else {}
                          },
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        Text(
                          "Contact Information:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 209, 207, 207)),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Cannot be empty";
                            } else if (value.length > 10) {
                              return "Only 10 digits required";
                            }
                            return null;
                          },
                          controller: mobileNumber,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "Mobile Number ",
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Color.fromARGB(255, 209, 207, 207)),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Cannot be empty";
                            }
                            return null;
                          },
                          controller: socialLinks,
                          decoration: InputDecoration(
                              hintText: "Facebook Profile Link",
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Color.fromARGB(255, 209, 207, 207)),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Marital Status:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 209, 207, 207)),
                              ),
                              Radio<String>(
                                value: 'single',
                                groupValue: _maritalStatus,
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) =>
                                        Color.fromARGB(255, 209, 207, 207)),
                                onChanged: (value) {
                                  setState(() {
                                    _maritalStatus = value ?? '';
                                  });
                                },
                              ),
                              Text(
                                'Single',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 209, 207, 207)),
                              ),
                              Radio<String>(
                                value: 'married',
                                groupValue: _maritalStatus,
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) =>
                                        Color.fromARGB(255, 209, 207, 207)),
                                onChanged: (value) {
                                  setState(() {
                                    _maritalStatus = value ?? '';
                                  });
                                },
                              ),
                              Text('Married',
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 209, 207, 207))),
                              Radio<String>(
                                value: 'divorced',
                                groupValue: _maritalStatus,
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) =>
                                        Color.fromARGB(255, 209, 207, 207)),
                                onChanged: (value) {
                                  setState(() {
                                    _maritalStatus = value ?? '';
                                  });
                                },
                              ),
                              Text('Divorced',
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 209, 207, 207))),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Email:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 209, 207, 207)),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
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
                              hintText: 'e.g. ccr@gmail.com',
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Color.fromARGB(255, 209, 207, 207)),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "Password:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 209, 207, 207)),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Cannot be empty";
                            }
                            return null;
                          },
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: 'Strong password',
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Color.fromARGB(255, 209, 207, 207)),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Center(
                          child: SizedBox(
                            width: 140.0,
                            height: 50.0,
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    // final int id = 1;
                                    // final String username = fullName.text;
                                    // final String email = emailController.text;
                                    // final String password =
                                    //     passwordController.text;
                                    int id = generateRandomId();
                                    await registerUserData(id);
                                    await registerUserDetailsData(id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Data submitted')),
                                    );
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginForm()));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    backgroundColor:
                                        Color.fromARGB(255, 63, 66, 73)),
                                child: Text("Sign Up")),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 209, 207, 207)),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            LoginForm()),
                                    (Route<dynamic> route) => false);
                              },
                              child: Text(
                                "Click here",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 209, 207, 207),
                                    decoration: TextDecoration.underline),
                              ),
                            )
                          ],
                        )
                      ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
