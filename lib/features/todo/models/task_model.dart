class TaskModel {
  int? id;
  String? title;
  String? description;
  bool isCompleted;
  DateTime? date;
  DateTime? startTime;
  DateTime? endTime;
  bool reminder;
  bool repeat;

  TaskModel({
    this.id,
    this.title,
    this.description,
    this.isCompleted = false,
    this.date,
    this.startTime,
    this.endTime,
    this.reminder = false,
    this.repeat = true,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as int?,
      title: map['title'] as String?,
      description: map['description'] as String?,
      isCompleted: (map['isCompleted'] as num) == 1,
      date: DateTime.parse(map['date'] as String),
      startTime: DateTime.parse(map['startTime'] as String),
      endTime: DateTime.parse(map['endTime'] as String),
      reminder: (map['reminder'] as num) == 1,
      repeat: (map['repeat'] as num) == 1,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'isCompleted': isCompleted ? 1 : 0,
        'date': date.toString(),
        'startTime': startTime.toString(),
        'endTime': endTime.toString(),
        'reminder': reminder ? 1 : 0,
        'repeat': repeat ? 1 : 0,
      };
}
