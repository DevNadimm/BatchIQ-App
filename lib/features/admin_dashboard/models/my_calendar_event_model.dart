class MyCalendarEventModel {
  final String id;
  final String createdBy;
  final String date;
  final String description;
  final String eventType;
  final String title;

  MyCalendarEventModel({
    required this.id,
    required this.createdBy,
    required this.date,
    required this.description,
    required this.eventType,
    required this.title,
  });

  factory MyCalendarEventModel.fromFirestore(Map<String, dynamic> data, String id) {
    return MyCalendarEventModel(
      id: id,
      createdBy: data['createdBy'] ?? '',
      date: data['date'] ?? '',
      description: data['description'] ?? '',
      eventType: data['eventType'] ?? '',
      title: data['title'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'createdBy': createdBy,
      'date': date,
      'description': description,
      'eventType': eventType,
      'title': title,
    };
  }
}
