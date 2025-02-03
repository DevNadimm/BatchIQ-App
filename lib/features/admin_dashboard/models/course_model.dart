class CourseModel {
  final String id;
  final String courseName;
  final String courseCode;
  final String instructorName;
  final String createdAt;
  final String updatedAt;

  CourseModel({
    required this.id,
    required this.courseName,
    required this.courseCode,
    required this.instructorName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CourseModel.fromFirestore(Map<String, dynamic> data, String id) {
    return CourseModel(
      id: id,
      courseName: data['courseName'] ?? '',
      courseCode: data['courseCode'] ?? '',
      instructorName: data['instructorName'] ?? '',
      createdAt: data['createdAt'] ?? '',
      updatedAt: data['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'courseName': courseName,
      'courseCode': courseCode,
      'instructorName': instructorName,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
