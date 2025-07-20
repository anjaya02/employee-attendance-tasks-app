import 'package:intl/intl.dart';

// Task priority levels
enum Priority { low, medium, high }

// Task status options
enum TaskStatus { notStarted, inProgress, done }

class Task {
  final String id;
  final String name;
  final DateTime dueDate;
  final Priority priority;
  final TaskStatus status;

  Task({
    required this.id,
    required this.name,
    required this.dueDate,
    required this.priority,
    required this.status,
  });

  // Format due date to MM/DD/YYYY as required
  String get formattedDueDate {
    return DateFormat('MM/dd/yyyy').format(dueDate);
  }

  // Convert priority enum to readable string
  String get priorityString {
    switch (priority) {
      case Priority.low:
        return 'Low';
      case Priority.medium:
        return 'Medium';
      case Priority.high:
        return 'High';
    }
  }

  // Get status as string
  String get statusString {
    switch (status) {
      case TaskStatus.notStarted:
        return 'Not Started';
      case TaskStatus.inProgress:
        return 'In Progress';
      case TaskStatus.done:
        return 'Done';
    }
  }

  // Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dueDate': dueDate.millisecondsSinceEpoch,
      'priority': priority.index,
      'status': status.index,
    };
  }

  // Create from JSON
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String,
      name: json['name'] as String,
      dueDate: DateTime.fromMillisecondsSinceEpoch(json['dueDate'] as int),
      priority: Priority.values[json['priority'] as int],
      status: TaskStatus.values[json['status'] as int],
    );
  }

  // Create a copy with updated fields
  Task copyWith({
    String? id,
    String? name,
    DateTime? dueDate,
    Priority? priority,
    TaskStatus? status,
  }) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      status: status ?? this.status,
    );
  }

  // Parse priority from string
  static Priority priorityFromString(String priority) {
    switch (priority.toLowerCase()) {
      case 'low':
        return Priority.low;
      case 'medium':
        return Priority.medium;
      case 'high':
        return Priority.high;
      default:
        return Priority.low;
    }
  }

  // Parse status from string
  static TaskStatus statusFromString(String status) {
    switch (status.toLowerCase()) {
      case 'not started':
        return TaskStatus.notStarted;
      case 'in progress':
        return TaskStatus.inProgress;
      case 'done':
        return TaskStatus.done;
      default:
        return TaskStatus.notStarted;
    }
  }
}
