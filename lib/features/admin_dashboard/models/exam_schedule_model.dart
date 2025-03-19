class ExamScheduleModel {
  final String id;
  final String course;
  final String courseCode;
  final String teacher;
  final String scheduledDate;
  final String examType;
  final String createdBy;
  final String createdAt;

  ExamScheduleModel({
    required this.id,
    required this.course,
    required this.courseCode,
    required this.teacher,
    required this.scheduledDate,
    required this.examType,
    required this.createdBy,
    required this.createdAt,
  });

  factory ExamScheduleModel.fromFirestore(Map<String, dynamic> data, String id) {
    return ExamScheduleModel(
      id: id,
      course: data['course'] ?? '',
      courseCode: data['courseCode'] ?? '',
      teacher: data['teacher'] ?? '',
      scheduledDate: data['scheduledDate'] ?? '',
      examType: data['examType'] ?? '',
      createdBy: data['createdBy'] ?? '',
      createdAt: data['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'course': course,
      'courseCode': courseCode,
      'teacher': teacher,
      'scheduledDate': scheduledDate,
      'examType': examType,
      'createdBy': createdBy,
      'createdAt': createdAt,
    };
  }
}
