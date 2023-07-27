import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'project_list.dart';

class ProjectImplement extends StatefulWidget {
  const ProjectImplement({super.key});

  @override
  State<ProjectImplement> createState() => _ProjectImplementState();
}

class _ProjectImplementState extends State<ProjectImplement> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController projectTitle = TextEditingController();
  TextEditingController startDateInput = TextEditingController();
  TextEditingController endDateInput = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController organizationName = TextEditingController();
  List<String> textFieldValues = [];
  String _associated = '';

  bool readOrganizationOrNot() {
    if (_associated == "yes") {
      return false;
    }
    return true;
  }
  // List<workExperienceFields> workExperienceListMethod(
  //     String jobTitle,
  //     String summary,
  //     String companyName,
  //     String startDateInput,
  //     String endDateInput) {
  //   List<workExperienceFields> workExperienceList = [
  //     workExperienceFields(
  //         jobTitle: jobTitle,
  //         summary: summary,
  //         companyName: companyName,
  //         startDate: startDateInput,
  //         endDate: endDateInput)
  //   ];
  //   return workExperienceList;
  // }

  void initState() {
    organizationName.text = "None";
    startDateInput.text = "";
    endDateInput.text = "";
    description.text = "";
    projectTitle.text = ""; //set the initial value of text field
    super.initState();
  }
  // void addTextField() {
  //   setState(() {
  //     textFieldValues.add('');
  //   });
  // }

  // void updateTextFieldValue(int index, String value) {
  //   setState(() {
  //     textFieldValues[index] = value;
  //   });
  // }

  // void removeTextField(int index) {
  //   setState(() {
  //     textFieldValues.removeAt(index);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Project Form'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Center(
                    child: Text('Add Project Details'),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    padding: EdgeInsets.all(40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                            controller: projectTitle,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Project Title: '),
                            // onChanged: (value) {
                            //   setState(() {});
                            // },
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
                              } else if (value.length > 100) {
                                return 'Text must not exceed 10 characters';
                              } else if (!regex.hasMatch(value)) {
                                return 'Only alphabetic characters are allowed';
                              }
                              return null;
                            },
                            controller: description,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Project Description: '),
                            // onChanged: (value) {
                            //   setState(() {});
                            // },
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          width: 250,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Cannot be empty";
                              }
                              return null;
                            },
                            controller: startDateInput,
                            decoration: InputDecoration(
                                icon: Icon(Icons.calendar_today),
                                labelText: "Start Date"),
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
                                  startDateInput.text =
                                      formattedDate; //set output date to TextField value.
                                });
                              } else {}
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          width: 250,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Cannot be empty";
                              }
                              return null;
                            },
                            controller: endDateInput,
                            decoration: InputDecoration(
                                icon: Icon(Icons.calendar_today),
                                labelText: "End Date"),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime(2022),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2024),
                              );
                              if (pickedDate != null) {
                                print(
                                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(
                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                setState(() {
                                  endDateInput.text =
                                      formattedDate; //set output date to TextField value.
                                });
                              } else {}
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Text('Associated organization: '),
                            Radio<String>(
                              value: 'yes',
                              groupValue: _associated,
                              onChanged: (value) {
                                setState(() {
                                  _associated = value ?? '';
                                });
                              },
                            ),
                            Text('Yes'),
                            Radio<String>(
                              value: 'no',
                              groupValue: _associated,
                              onChanged: (value) {
                                setState(() {
                                  _associated = value ?? '';
                                });
                              },
                            ),
                            Text('No'),
                          ],
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
                            controller: organizationName,
                            readOnly: readOrganizationOrNot(),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Organization Name'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          projectFieldsList.add(ProjectFields(
                              projectTitle: projectTitle.text,
                              organizationName: organizationName.text,
                              startDate: startDateInput.text.toString(),
                              endDate: endDateInput.text.toString(),
                              description: description.text));

                          print('clicked');
                          Navigator.pop(context, projectFieldsList);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Data submitted')),
                          );
                        }
                      },
                      child: Text('Submit'))
                ],
              ),
            ),
          ),
        ));
  }
}
