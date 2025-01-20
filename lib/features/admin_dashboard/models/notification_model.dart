class NotificationModel {
  final String id;
  final String title;
  final String body;
  final String createdAt;
  final String updatedAt;
  final String createdBy;
  final String type;
  final bool read;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.type,
    required this.read,
  });

  factory NotificationModel.fromFirestore(Map<String, dynamic> data, String id) {
    return NotificationModel(
      id: id,
      title: data['title'] ?? '',
      body: data['body'] ?? '',
      createdAt: data['createdAt'] ?? '',
      updatedAt: data['updatedAt'] ?? '',
      createdBy: data['createdBy'] ?? '',
      type: data['type'] ?? '',
      read: data['read'] ?? false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'body': body,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'createdBy': createdBy,
      'type': type,
      'read': read,
    };
  }
}
