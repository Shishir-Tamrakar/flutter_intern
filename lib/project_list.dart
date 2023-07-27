class ProjectFields {
  String projectTitle;
  String description;
  String startDate;
  String endDate;
  String organizationName;
  ProjectFields(
      {required this.projectTitle,
      required this.description,
      required this.startDate,
      required this.endDate,
      required this.organizationName});
  Map<String, dynamic> toJson() {
    return {
      'projectTitle': projectTitle,
      'description': description,
      'startDate': startDate,
      'endDate': endDate,
      'organizationName': organizationName,
      // Map other properties accordingly...
    };
  }

  factory ProjectFields.fromJson(Map<String, dynamic> json) {
    return ProjectFields(
        projectTitle: json['projectTitle'],
        description: json['description'],
        startDate: json['startDate'],
        endDate: json['endDate'],
        organizationName: json['organizationName']);
  }
}

List<ProjectFields> projectFieldsList = [];
