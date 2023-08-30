class workExperienceFields {
  String jobTitle;
  String summary;
  String companyName;
  String startDate;
  String endDate;
  workExperienceFields(
      {required this.jobTitle,
      required this.summary,
      required this.companyName,
      required this.startDate,
      required this.endDate});
  Map<String, dynamic> toJson() {
    return {
      'jobTitle': jobTitle,
      'summary': summary,
      'companyName': companyName,
      'startDate': startDate,
      'endDate': endDate,

      // Map other properties accordingly...
    };
  }

  factory workExperienceFields.fromJson(Map<String, dynamic> json) {
    return workExperienceFields(
      jobTitle: json['jobTitle'],
      summary: json['summary'],
      companyName: json['companyName'],
      startDate: json['startDate'],
      endDate: json['endDate'],
    );
  }
}

List<workExperienceFields> workFieldsList = [];
