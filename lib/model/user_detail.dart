import 'dart:io';
import 'work_list.dart';
import 'education_list.dart';

class UserDetail {
  int id;
  File profileImage;
  File coverImage;
  String summary;
  String gender;
  String dob;
  String maritalStatus;
  List<workExperienceFields> workExperience;
  List<EducationFields> educationFields;
  List<String> skills;
  String hobbies;
  List<String> language;
  String mobileNumber;
  String socialLinks;

  UserDetail({
    required this.id,
    required this.profileImage,
    required this.coverImage,
    required this.summary,
    required this.gender,
    required this.dob,
    required this.maritalStatus,
    required this.workExperience,
    required this.educationFields,
    required this.skills,
    required this.hobbies,
    required this.language,
    required this.mobileNumber,
    required this.socialLinks,
  });
  Map<String, dynamic> toJson() {
    String profileImagePath = profileImage.path;
    String coverImagePath = coverImage.path;
    return {
      'id': id,
      'profileImage': profileImagePath,
      'coverImage': coverImagePath,
      'summary': summary,
      'gender': gender,
      'dob': dob,
      'maritalStatus': maritalStatus,
      'workExperience': workExperience.map((e) => e.toJson()).toList(),
      'educationFields': educationFields.map((e) => e.toJson()).toList(),
      'skills': skills,
      'hobbies': hobbies,
      'language': language,
      'mobileNumber': mobileNumber,
      'socialLinks': socialLinks,
      // Map other properties accordingly...
    };
  }

  factory UserDetail.fromJson(Map<String, dynamic> json) {
    File? profileImageFile =
        json['profileImage'] != "" ? File(json['profileImage']) : null;
    File? coverImageFile =
        json['coverImage'] != "" ? File(json['coverImage']) : null;
    return UserDetail(
        id: json['id'],
        profileImage: profileImageFile!,
        coverImage: coverImageFile!,
        summary: json['summary'],
        gender: json['gender'],
        dob: json['dob'],
        maritalStatus: json['maritalStatus'],
        workExperience: List<workExperienceFields>.from(json['workExperience']
            .map((e) => workExperienceFields.fromJson(e))),
        educationFields: List<EducationFields>.from(
            json['educationFields'].map((e) => EducationFields.fromJson(e))),
        skills: List<String>.from(json['skills']),
        hobbies: json['hobbies'],
        language: List<String>.from(json['language']),
        mobileNumber: json['mobileNumber'],
        socialLinks: json['socialLinks']);
  }
}

// List<UserDetail> userDetailList = [];
