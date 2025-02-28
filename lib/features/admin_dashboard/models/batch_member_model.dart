class BatchMemberModel {
  final String id;
  final String name;
  final String role;
  final String joinedAt;

  BatchMemberModel({
    required this.id,
    required this.name,
    required this.role,
    required this.joinedAt,
  });

  factory BatchMemberModel.fromFirestore(Map<String, dynamic> data, String id) {
    return BatchMemberModel(
      id: id,
      name: data['name'] ?? '',
      role: data['role'] ?? '',
      joinedAt: data['joinedAt'] ?? '',
    );
  }
}
