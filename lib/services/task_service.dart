import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class TaskService {
  static const String _tasksKey = 'tasks';

  // Save tasks
  static Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = tasks.map((task) => task.toJson()).toList();
    await prefs.setString(_tasksKey, jsonEncode(tasksJson));
  }

  // Get all tasks
  static Future<List<Task>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksString = prefs.getString(_tasksKey);

    if (tasksString == null) {
      return [];
    }

    try {
      final tasksJson = jsonDecode(tasksString) as List;
      return tasksJson
          .map((json) => Task.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  // Add a new task
  static Future<void> addTask(Task task) async {
    final tasks = await getTasks();
    tasks.add(task);
    await saveTasks(tasks);
  }

  // Update a task
  static Future<void> updateTask(Task updatedTask) async {
    final tasks = await getTasks();
    final index = tasks.indexWhere((task) => task.id == updatedTask.id);

    if (index != -1) {
      tasks[index] = updatedTask;
      await saveTasks(tasks);
    }
  }

  // Delete a task
  static Future<void> deleteTask(String taskId) async {
    final tasks = await getTasks();
    tasks.removeWhere((task) => task.id == taskId);
    await saveTasks(tasks);
  }

  // Update task status
  static Future<void> updateTaskStatus(
    String taskId,
    TaskStatus newStatus,
  ) async {
    final tasks = await getTasks();
    final index = tasks.indexWhere((task) => task.id == taskId);

    if (index != -1) {
      tasks[index] = tasks[index].copyWith(status: newStatus);
      await saveTasks(tasks);
    }
  }

  // Generate unique ID for new tasks
  static String generateTaskId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  // Simulate error for testing
  static Future<void> simulateError() async {
    throw Exception('Simulated error during task save/load operation');
  }
}
