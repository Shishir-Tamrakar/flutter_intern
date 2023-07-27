import 'package:flutter/material.dart';
import 'work_experience_fields.dart';
import 'work_list.dart';
import 'education_fields.dart';
import 'education_list.dart';
import 'project_fields.dart';
import 'project_list.dart';
import 'cv_list.dart';
import 'cv_display.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TextFieldImplement extends StatefulWidget {
  const TextFieldImplement({super.key});

  @override
  State<TextFieldImplement> createState() => _TextFieldImplementState();
}

class _TextFieldImplementState extends State<TextFieldImplement> {
  ValueNotifier<List<workExperienceFields>> workFieldsNotifier =
      ValueNotifier<List<workExperienceFields>>(workFieldsList);

  // WorkExperienceImplement _workExperienceImplement = WorkExperienceImplement();
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController middleName = TextEditingController();
  TextEditingController age = TextEditingController();
  String _gender = '';
  List<String> skills = [
    'Flutter',
    'Dart',
    'Android',
    'iOS',
    'Java',
    'Python',
    'React',
    'Angular',
  ];
  List<String> selectedSkills = [];
  List<String> selectedLanguages = [];
  List<String> selectedInterests = [];
  ValueNotifier<bool> _switchValue = ValueNotifier<bool>(false);
  List<Map<String, dynamic>> _languageList = [
    {
      "name": "Dart",
      "isChecked": false,
    },
    {
      "name": "Java",
      "isChecked": false,
    },
    {
      "name": "Python",
      "isChecked": false,
    },
    {
      "name": "PHP",
      "isChecked": false,
    },
  ];
  List<Map<String, dynamic>> _interestAreaList = [
    {
      "name": "Web Application",
      "isChecked": false,
    },
    {
      "name": "Mobile Application",
      "isChecked": false,
    },
    {
      "name": "QA Engineer",
      "isChecked": false,
    },
    {
      "name": "Manager",
      "isChecked": false,
    },
    {
      "name": "DevOps",
      "isChecked": false,
    },
    {
      "name": "UI/UX Designer",
      "isChecked": false,
    },
  ];
  void _toggleSkillSelection(String skill) {
    setState(() {
      if (selectedSkills.contains(skill)) {
        selectedSkills.remove(skill);
      } else {
        selectedSkills.add(skill);
      }
    });
  }

  void _toggleLanguageSelection(String language) {
    setState(() {
      if (selectedLanguages.contains(language)) {
        selectedLanguages.remove(language);
      } else {
        selectedLanguages.add(language);
      }
    });
  }

  void _toggleInterestSelection(String interest) {
    setState(() {
      if (selectedInterests.contains(interest)) {
        selectedInterests.remove(interest);
      } else {
        selectedInterests.add(interest);
      }
    });
  }

  Future<void> saveCvData() async {
    Map<String, dynamic> cvEmptyList = {};
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final jsonString = sharedPreferences.getString('dataList');
    if (jsonString != null) {
      try {
        final jsonData = jsonDecode(jsonString);
        if (jsonData is List<dynamic>) {
          cvFieldsList =
              jsonData.map((json) => CvFields.fromJson(json)).toList();
        } else if (jsonData is Map<String, dynamic>) {
          cvFieldsList.add(CvFields.fromJson(jsonData));
        }
      } catch (e) {
        print("Error data: $e");
      }
    }
    cvFieldsList.add(CvFields(
        firstName: firstName.text,
        lastName: lastName.text,
        middleName: middleName.text,
        gender: _gender,
        age: age.text,
        skills: selectedSkills,
        workExperience: workFieldsList,
        educationFields: educationFieldsList,
        projectFields: projectFieldsList,
        language: selectedLanguages,
        interest: selectedInterests));

    List<Map<String, dynamic>> jsonDataList =
        cvFieldsList.map((cv) => cv.toJson()).toList();
    cvEmptyList[firstName.text] = jsonDataList;
    String jsonData = json.encode(jsonDataList);
    sharedPreferences.setString('dataList', jsonData);
  }

  @override
  void initState() {
    // TODO: implement initState
    firstName.text = "";
    middleName.text = "";
    lastName.text = "";
    age.text = "";
    if (workFieldsList.isNotEmpty) {
      setState(() {
        workFieldsList = workFieldsList;
      });
    }
    workFieldsList = workFieldsList;
    projectFieldsList = projectFieldsList;
    super.initState();
  }

  // List<workExperienceFields> workFields = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      padding: EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Name Information:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: 250.0,
              child: TextFormField(
                validator: (value) {
                  final regex = RegExp(r'^[a-zA-Z]+$');
                  if (value == null || value.isEmpty) {
                    return "Cannot be empty";
                  } else if (value.length > 10) {
                    return 'Text must not exceed 10 characters';
                  } else if (!regex.hasMatch(value)) {
                    return 'Only alphabetic characters are allowed';
                  }
                  return null;
                },
                controller: firstName,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'First Name'),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(
              width: 250.0,
              child: TextFormField(
                validator: (value) {
                  final regex = RegExp(r'^[a-zA-Z]+$');
                  if (value == null || value.isEmpty) {
                    return "Cannot be empty";
                  } else if (value.length > 10) {
                    return 'Text must not exceed 10 characters';
                  } else if (!regex.hasMatch(value)) {
                    return 'Only alphabetic characters are allowed';
                  }
                  return null;
                },
                controller: middleName,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Middle Name'),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(
              width: 250.0,
              child: TextFormField(
                validator: (value) {
                  final regex = RegExp(r'^[a-zA-Z]+$');
                  if (value == null || value.isEmpty) {
                    return "Cannot be empty";
                  } else if (value.length > 10) {
                    return 'Text must not exceed 10 characters';
                  } else if (!regex.hasMatch(value)) {
                    return 'Only alphabetic characters are allowed';
                  }
                  return null;
                },
                controller: lastName,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Last Name'),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(
              width: 250.0,
              child: TextFormField(
                validator: (value) {
                  final regex = RegExp(r'^\d+$');
                  if (value == null || value.isEmpty) {
                    return "Cannot be empty";
                  } else if (value.length > 3) {
                    return 'Age must not exceed 3 characters';
                  } else if (!regex.hasMatch(value)) {
                    return 'Only digits are allowed';
                  }
                  return null;
                },
                controller: age,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Age'),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Gender:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Radio<String>(
                  value: 'male',
                  groupValue: _gender,
                  onChanged: (value) {
                    setState(() {
                      _gender = value ?? '';
                    });
                  },
                ),
                Text('Male'),
                Radio<String>(
                  value: 'female',
                  groupValue: _gender,
                  onChanged: (value) {
                    setState(() {
                      _gender = value ?? '';
                    });
                  },
                ),
                Text('Female'),
                Radio<String>(
                  value: 'other',
                  groupValue: _gender,
                  onChanged: (value) {
                    setState(() {
                      _gender = value ?? '';
                    });
                  },
                ),
                Text('Other'),
              ],
            ),
            Text(
              'Skills:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5.0,
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: _skillsOption(),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Text(
                  'Work Experience:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 100.0,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const workExperienceImplement()),
                      );
                    },
                    child: Text('Add')),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            ValueListenableBuilder<List<workExperienceFields>>(
                valueListenable: workFieldsNotifier,
                builder: (context, workFieldsList, _) {
                  return Wrap(
                    runSpacing: 9.0,
                    children: _workFieldsUi(),
                  );
                }),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Text(
                  'Education:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 143.0,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EducationImplement()),
                      );
                    },
                    child: Text('Add')),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Wrap(
              runSpacing: 9.0,
              children: _educationListUi(),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Text('Other Projects',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(
                  width: 120.0,
                ),
                ValueListenableBuilder(
                    valueListenable: _switchValue,
                    builder: (context, value, child) {
                      return Switch(
                        value: value,
                        onChanged: (newValue) {
                          setState(() {
                            _switchValue.value = newValue;
                          });
                          if (newValue) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ProjectImplement()),
                            );
                          }
                          // _switchValue.value = !newValue;
                        },
                      );
                    }),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Wrap(
              runSpacing: 9.0,
              children: _projectFieldsUi(),
            ),
            SizedBox(
              height: 20,
            ),
            Text('Languages: '),
            SizedBox(
              height: 10.0,
            ),
            SingleChildScrollView(
              child: Row(
                  children: _languageList.map((language) {
                return Row(
                  children: [
                    Checkbox(
                        value: language['isChecked'],
                        onChanged: (bool? value) {
                          setState(() {
                            language["isChecked"] = value;

                            _toggleLanguageSelection(language["name"]);
                          });
                        }),
                    Text(language["name"]),
                  ],
                );
              }).toList()),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text('Interest Areas'),
            SizedBox(
              height: 10.0,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: _interestAreaList.map((interest) {
                return Row(
                  children: [
                    Checkbox(
                        value: interest['isChecked'],
                        onChanged: (bool? value) {
                          setState(() {
                            interest["isChecked"] = value;
                            _toggleInterestSelection(interest["name"]);
                          });
                        }),
                    Text(interest["name"]),
                  ],
                );
              }).toList()),
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.

                    await saveCvData();
                    _formKey.currentState!.reset();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Data submitted')),
                    );
                  }
                },
                child: Text('Submit'),
              ),
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CvDisplay()),
                    );
                  },
                  child: Text('View CV')),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _skillsOption() {
    return skills.map((skill) {
      final isSelected = selectedSkills.contains(skill);
      return Chip(
        label: Text(skill),
        backgroundColor: isSelected ? Colors.blue : Colors.grey,
        labelStyle: TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        onDeleted: () {
          _toggleSkillSelection(skill);
        },
        deleteIconColor: Colors.white,
      );
    }).toList();
  }

  List<Widget> _workFieldsUi() {
    return workFieldsList.map(
      (e) {
        return Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.redAccent),
                borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Job Title: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.jobTitle)
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Summary: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.summary)
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Company Name: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.companyName)
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Start Date: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.startDate)
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'End Date: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.endDate)
                  ],
                ),
                Center(
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        workFieldsList.remove(e);
                      });
                    },
                    icon: Icon(
                      Icons.delete,
                    ),
                  ),
                )
              ],
            ));
      },
    ).toList();
  }

  List<Widget> _educationListUi() {
    return educationFieldsList.map(
      (e) {
        return Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.redAccent),
                borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Organization Name: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.organizationName)
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Level: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.level)
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'start date: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.startDate)
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'End Datee: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.endDate)
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Achievements: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.achievements)
                  ],
                ),
                Center(
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        educationFieldsList.remove(e);
                      });
                    },
                    icon: Icon(
                      Icons.delete,
                    ),
                  ),
                )
              ],
            ));
      },
    ).toList();
  }

  List<Widget> _projectFieldsUi() {
    return projectFieldsList.map(
      (e) {
        return Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.redAccent),
                borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Project Title: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.projectTitle)
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Description: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.description)
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Start Date: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.startDate)
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'End Date: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.endDate)
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Organization Name: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(e.organizationName)
                  ],
                ),
                Center(
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        projectFieldsList.remove(e);
                      });
                    },
                    icon: Icon(
                      Icons.delete,
                    ),
                  ),
                )
              ],
            ));
      },
    ).toList();
  }
}
