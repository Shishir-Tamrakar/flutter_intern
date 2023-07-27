import 'work_list.dart';
import 'education_list.dart';
import 'project_list.dart';

class CvFields {
  String firstName;
  String lastName;
  String middleName;
  String gender;
  String age;
  List<String> skills;
  List<workExperienceFields> workExperience;
  List<EducationFields> educationFields;
  List<ProjectFields> projectFields;
  List<String> language;
  List<String> interest;
  CvFields({
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.gender,
    required this.age,
    required this.skills,
    required this.workExperience,
    required this.educationFields,
    required this.projectFields,
    required this.language,
    required this.interest,
  });
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'middleName': middleName,
      'gender': gender,
      'age': age,
      'skills': skills,
      'workExperience': workExperience.map((e) => e.toJson()).toList(),
      'educationFields': educationFields.map((e) => e.toJson()).toList(),
      'projectFields': projectFields.map((e) => e.toJson()).toList(),
      'language': language,
      'interest': interest
      // Map other properties accordingly...
    };
  }

  factory CvFields.fromJson(Map<String, dynamic> json) {
    return CvFields(
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],
      age: json['age'],
      gender: json['gender'],
      skills: List<String>.from(json['skills']),
      workExperience: List<workExperienceFields>.from(
        json['workExperience'].map((e) => workExperienceFields.fromJson(e)),
      ),
      educationFields: List<EducationFields>.from(
        json['educationFields'].map((e) => EducationFields.fromJson(e)),
      ),
      projectFields: List<ProjectFields>.from(
        json['projectFields'].map((e) => ProjectFields.fromJson(e)),
      ),
      language: List<String>.from(json['language']),
      interest: List<String>.from(json['interest']),
    );
  }
}

List<CvFields> cvFieldsList = [];
