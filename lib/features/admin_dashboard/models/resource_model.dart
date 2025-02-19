import 'package:cloud_firestore/cloud_firestore.dart';

class ResourceModel {
  final String id;
  final String title;
  final String description;
  final String courseName;
  final String courseCode;
  final String resourcesType;
  final String url;
  final Timestamp createdAt;
  final Timestamp updatedAt;
  final String createdBy;

  ResourceModel({
    required this.id,
    required this.title,
    required this.description,
    required this.courseName,
    required this.courseCode,
    required this.resourcesType,
    required this.url,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
  });

  factory ResourceModel.fromFirestore(Map<String, dynamic> data, String id) {
    return ResourceModel(
      id: id,
      courseName: data['courseName'] ?? '',
      courseCode: data['courseCode'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
      createdBy: data['createdBy'] ?? '',
      description: data['description'] ?? '',
      resourcesType: data['resourcesType'] ?? '',
      title: data['title'] ?? '',
      updatedAt: data['updatedAt'] ?? Timestamp.now(),
      url: data['url'] ?? '',
    );
  }
}
