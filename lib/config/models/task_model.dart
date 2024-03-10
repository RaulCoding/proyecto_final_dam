import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Task taskFromJson(String str) => Task.fromJson(json.decode(str));

String taskToJson(Task data) => json.encode(data.toJson());

class Task {
    String task;
    Timestamp? timestamp;
    String userId;

    Task({
        required this.task,
        this.timestamp,
        required this.userId,
    });

    factory Task.fromJson(Map<String, dynamic> json) => Task(
        task: json["task"],
        timestamp: json["timestamp"],
        userId: json["userID"],
    );

    Map<String, dynamic> toJson() => {
        "task": task,
        "timestamp": Timestamp.now(),
        "userID": userId,
    };
}
