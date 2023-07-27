import 'dart:ui';

import 'package:flutter/material.dart';
import 'cv_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CvDisplay extends StatefulWidget {
  const CvDisplay({super.key});

  @override
  State<CvDisplay> createState() => _CvDisplayState();
}

class _CvDisplayState extends State<CvDisplay> {
  List<CvFields> cvDataList = [];
  Future<List<String>> getCvData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('dataList');
    if (jsonData != null) {
      try {
        final decodedData = json.decode(jsonData) as List<dynamic>;

        // List<String> dataList =
        //     decodedData.map((item) => item.toString()).toList();
        setState(() {
          cvDataList = decodedData.map((e) => CvFields.fromJson(e)).toList();
        });
      } catch (e) {
        print("error ${e}");
      }
      // return dataList;
    } else {
      cvDataList = [];
    }
    return []; // Return an empty list if no data is found in SharedPreferences
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCvData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CV Details'),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: cvDataList.length,
              itemBuilder: (BuildContext context, index) {
                return Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white10),
                      color: Colors.white),
                  child: Column(
                    children: [
                      Text(
                        "User ${index + 1}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text(
                            'First Name:  ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(cvDataList[index].firstName),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Text(
                            'Middle Name:  ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(cvDataList[index].middleName),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Text(
                            'Last Name:  ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(cvDataList[index].lastName),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Text(
                            'Age:  ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(cvDataList[index].age),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Text(
                            'Skills:  ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(cvDataList[index].skills.join(',')),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Work Experience Details:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: cvDataList[index].workExperience.length,
                          itemBuilder: (context, i) {
                            return Container(
                              padding: EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey, width: 3.0)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Job Title: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(cvDataList[index]
                                          .workExperience[i]
                                          .jobTitle),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Summary: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(cvDataList[index]
                                          .workExperience[i]
                                          .summary),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Company Name: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(cvDataList[index]
                                          .workExperience[i]
                                          .companyName),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Start Date: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(cvDataList[index]
                                          .workExperience[i]
                                          .startDate),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "End Date: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(cvDataList[index]
                                          .workExperience[i]
                                          .endDate),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Education Details:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: cvDataList[index].educationFields.length,
                          itemBuilder: (context, i) {
                            return Container(
                              padding: EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey, width: 3.0)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Organization Name: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(cvDataList[index]
                                          .educationFields[i]
                                          .organizationName),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Level: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(cvDataList[index]
                                          .educationFields[i]
                                          .level),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Start Date: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(cvDataList[index]
                                          .educationFields[i]
                                          .startDate),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "End Date: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(cvDataList[index]
                                          .educationFields[i]
                                          .endDate)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Achievements: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(cvDataList[index]
                                          .educationFields[i]
                                          .achievements)
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text('Project Fields:',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10.0,
                      ),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: cvDataList[index].projectFields.length,
                          itemBuilder: (context, i) {
                            return Container(
                              padding: EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey, width: 3.0)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text("Project Title: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text(cvDataList[index]
                                          .projectFields[i]
                                          .projectTitle),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Project Description: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text(cvDataList[index]
                                          .projectFields[i]
                                          .description),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Start Date: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text(cvDataList[index]
                                          .projectFields[i]
                                          .startDate),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("End Date: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text(cvDataList[index]
                                          .projectFields[i]
                                          .endDate),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Organization Name: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(cvDataList[index]
                                          .projectFields[i]
                                          .organizationName)
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Text(
                            'Languages:  ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                              child:
                                  Text(cvDataList[index].language.join(','))),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: [
                          Text(
                            'Interests:  ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(cvDataList[index].interest.join(',')),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Divider(
                        color: Colors.black,
                        thickness: 5.0,
                      )
                    ],
                  ),
                );
              })
        ]),
      ),
    );
  }
}
