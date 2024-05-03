// To parse this JSON data, do
//
//     final tasks = tasksFromJson(jsonString);

import 'dart:convert';

///Single Task
Task taskFromJson(String str) => Task.fromJson(json.decode(str));
String taskToJson(Task data) => json.encode(data.createTaskDataToJson());

/// Task List
List<Task> tasksFromJson(String str) =>
    List<Task>.from(json.decode(str).map((x) => Task.fromJson(x)));
String tasksToJson(List<Task> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.allTaskDataToJson())));

class Task {
  String? id;
  String? taskName;
  String? taskDescription;
  bool? status;
  String? userId;
  DateTime? creationDate;

  Task({
    this.id,
    this.taskName,
    this.taskDescription,
    this.status,
    this.userId,
    this.creationDate,
  });

  Task copyWith({
    String? id,
    String? taskName,
    String? taskDescription,
    bool? status,
    String? userId,
    DateTime? creationDate,
  }) =>
      Task(
        id: id ?? this.id,
        taskName: taskName ?? this.taskName,
        taskDescription: taskDescription ?? this.taskDescription,
        status: status ?? this.status,
        userId: userId ?? this.userId,
        creationDate: creationDate ?? this.creationDate,
      );

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["_id"],
        taskName: json["taskName"],
        taskDescription: json["taskDescription"],
        status: json["status"],
        userId: json["userId"],
        creationDate: json["creationDate"] == null
            ? null
            : DateTime.parse(json["creationDate"]),
      );

  Map<String, dynamic> allTaskDataToJson() => {
        "_id": id,
        "taskName": taskName,
        "taskDescription": taskDescription,
        "status": status,
        "userId": userId,
        "creationDate": creationDate?.toIso8601String(),
      };

  Map<String, dynamic> createTaskDataToJson() => {
        "taskName": taskName,
        "taskDescription": taskDescription,
        "status": status,
      };

  Map<String, dynamic> updateTaskNameToJson() => {
        "taskName": taskName,
      };
}
