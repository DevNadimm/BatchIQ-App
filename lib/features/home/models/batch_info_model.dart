class BatchInfoModel {
  final String name;
  final String description;
  final String createdAt;
  final String createdBy;

  BatchInfoModel({
    this.name = 'N/A',
    this.description = 'N/A',
    this.createdAt = 'N/A',
    this.createdBy = 'N/A',
  });

  factory BatchInfoModel.fromFirestore(Map<String, dynamic> data) {
    return BatchInfoModel(
      name: data['name'] ?? 'N/A',
      description: data['description'] ?? 'N/A',
      createdAt: data['createdAt'] ?? 'N/A',
      createdBy: data['createdBy'] ?? 'N/A',
    );
  }
}
