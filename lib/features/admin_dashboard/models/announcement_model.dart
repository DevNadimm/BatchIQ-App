class AnnouncementModel {
  final String id;
  final String title;
  final String message;
  final String createdAt;
  final String updatedAt;
  final String createdBy;
  final String type;

  AnnouncementModel({
    required this.id,
    required this.title,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.type,
  });

  factory AnnouncementModel.fromFirestore(Map<String, dynamic> data, String id) {
    return AnnouncementModel(
      id: id,
      title: data['title'] ?? '',
      message: data['message'] ?? '',
      createdAt: data['createdAt'] ?? '',
      updatedAt: data['updatedAt'] ?? '',
      createdBy: data['createdBy'] ?? '',
      type: data['type'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'message': message,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'createdBy': createdBy,
      'type': type,
    };
  }
}
