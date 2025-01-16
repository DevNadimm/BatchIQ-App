class AssignmentModel {
  final String id;
  final String createdBy;
  final String deadline;
  final String title;
  final String description;
  final String link;

  AssignmentModel({
    required this.id,
    required this.createdBy,
    required this.deadline,
    required this.title,
    required this.description,
    required this.link,
  });

  factory AssignmentModel.fromFirestore(Map<String, dynamic> data, String id) {
    return AssignmentModel(
      id: id,
      createdBy: data['createdBy'] ?? '',
      deadline: data['deadline'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      link: data['link'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'createdBy': createdBy,
      'deadline': deadline,
      'title': title,
      'description': description,
      'link': link,
    };
  }
}
