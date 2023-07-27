class EducationFields {
  String organizationName;
  String level;
  String startDate;
  String endDate;
  String achievements;
  EducationFields(
      {required this.organizationName,
      required this.startDate,
      required this.endDate,
      required this.level,
      required this.achievements});
  Map<String, dynamic> toJson() {
    return {
      'organizationName': organizationName,
      'level': level,
      'startDate': startDate,
      'endDate': endDate,
      'achievements': achievements,
      // Map other properties accordingly...
    };
  }

  factory EducationFields.fromJson(Map<String, dynamic> json) {
    return EducationFields(
        organizationName: json['organizationName'],
        level: json['level'],
        startDate: json['startDate'],
        endDate: json['endDate'],
        achievements: json['achievements']);
  }
}

List<EducationFields> educationFieldsList = [];
