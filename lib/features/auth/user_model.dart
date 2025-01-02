import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String role;
  final String? batchId;
  final DateTime createdAt;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    this.batchId,
    required this.createdAt,
  });

  factory UserModel.fromMap(String uid, Map<String, dynamic> data) {
    return UserModel(
      uid: uid,
      name: data['name'] ?? 'N/A',
      email: data['email'] ?? 'N/A',
      role: data['role'] ?? 'student',
      batchId: data['batchId'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}
