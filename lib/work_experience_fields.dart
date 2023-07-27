import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'work_list.dart';

class workExperienceImplement extends StatefulWidget {
  const workExperienceImplement({super.key});

  @override
  State<workExperienceImplement> createState() =>
      _workExperienceImplementState();
}

class _workExperienceImplementState extends State<workExperienceImplement> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController jobTitle = TextEditingController();
  TextEditingController summary = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController startDateInput = TextEditingController();
  TextEditingController endDateInput = TextEditingController();
  List<String> textFieldValues = [];

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
    jobTitle.text = "";
    summary.text = "";
    companyName.text = "";
    startDateInput.text = "";
    endDateInput.text = ""; //set the initial value of text field
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
          title: Text('Work Experience Information'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Center(
                    child: Text('Work Experience'),
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
                            controller: jobTitle,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Job Title'),
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
                                return 'Text must not exceed 100 characters';
                              } else if (!regex.hasMatch(value)) {
                                return 'Only alphabetic characters are allowed';
                              }
                              return null;
                            },
                            maxLines: 5,
                            controller: summary,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Summary'),
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
                            controller: companyName,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Company Name'),
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
                          setState(() {
                            workFieldsList.add(workExperienceFields(
                                jobTitle: jobTitle.text,
                                summary: summary.text,
                                companyName: companyName.text,
                                startDate: startDateInput.text.toString(),
                                endDate: endDateInput.text.toString()));
                          });

                          print('clicked');
                          Navigator.pop(context, workFieldsList);
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
