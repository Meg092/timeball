class TaskEntity {
  int id;
  DateTime createdTime;
  String name;
  DateTime taskTime;
  int bgType;

  TaskEntity({
    required this.id,
    required this.createdTime,
    required this.name,
    required this.taskTime,
    required this.bgType,
  });

  factory TaskEntity.fromJson(Map<String, dynamic> json) {
    return TaskEntity(
      id: json['id'],
      createdTime: DateTime.parse(json['createdTime']),
      name: json['name'],
      taskTime: DateTime.parse(json['taskTime']),
      bgType: json['bgType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdTime': createdTime.toIso8601String(),
      'name': name,
      'taskTime': taskTime.toIso8601String(),
      'bgType': bgType,
    };
  }

  String get taskTimeStr {
    final now = DateTime.now();
    if (taskTime.isBefore(now)) {
      return 'Expired';
    }
    final diff = taskTime.difference(now);
    return '${diff.inMinutes} minutes left';
  }
}