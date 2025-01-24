class ClassScheduleModel {
  final String id;
  final String day;
  final String startTime;
  final String endTime;
  final String courseCode;
  final String courseName;
  final String teacher;
  final String location;

  ClassScheduleModel({
    required this.id,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.courseCode,
    required this.courseName,
    required this.teacher,
    required this.location,
  });

  factory ClassScheduleModel.fromFirestore(Map<String, dynamic> data, String id) {
    return ClassScheduleModel(
      id: id,
      day: data['day'] ?? '',
      startTime: data['startTime'] ?? '',
      endTime: data['endTime'] ?? '',
      courseCode: data['courseCode'] ?? '',
      courseName: data['courseName'] ?? '',
      teacher: data['teacher'] ?? '',
      location: data['location'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'day': day,
      'startTime': startTime,
      'endTime': endTime,
      'courseCode': courseCode,
      'courseName': courseName,
      'teacher': teacher,
      'location': location,
    };
  }
}
