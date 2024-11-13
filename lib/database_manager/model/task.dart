import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String? id;
  String? title;

  String? description;
  Timestamp? taskDate;
  bool isDone;

  Task(
      {this.id,
        this.title,
        this.description,
        this.taskDate,
        this.isDone = false});

  Task.fromFireStore(Map<String, dynamic>? data)
      : this(
    id: data?['id'],
    title: data?['title'],
    description: data?['description'],
    taskDate: data?['taskDate'],
    isDone: data?['isDone'],
  );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'taskDate': taskDate,
      'isDone': isDone
    };
  }
}