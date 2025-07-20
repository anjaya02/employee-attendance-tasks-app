import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../models/attendance_record.dart';

class AttendanceService {
  static const String _nameKey = 'employee_name';
  static const String _attendanceKey = 'attendance_records';

  // Save employee name
  static Future<void> saveEmployeeName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nameKey, name);
  }

  // Get employee name
  static Future<String?> getEmployeeName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_nameKey);
  }

  // Save attendance records
  static Future<void> saveAttendanceRecords(
    List<AttendanceRecord> records,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final recordsJson = records.map((record) => record.toJson()).toList();
    await prefs.setString(_attendanceKey, jsonEncode(recordsJson));
  }

  // Get all attendance records
  static Future<List<AttendanceRecord>> getAttendanceRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final recordsString = prefs.getString(_attendanceKey);

    if (recordsString == null) {
      return [];
    }

    try {
      final recordsJson = jsonDecode(recordsString) as List;
      return recordsJson
          .map(
            (json) => AttendanceRecord.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      return [];
    }
  }

  // Get today's attendance record
  static Future<AttendanceRecord?> getTodaysRecord() async {
    final records = await getAttendanceRecords();
    final today = DateFormat('MM/dd/yyyy').format(DateTime.now());

    try {
      return records.firstWhere((record) => record.date == today);
    } catch (e) {
      return null;
    }
  }

  // Check in
  static Future<AttendanceRecord> checkIn() async {
    final now = DateTime.now();
    final date = DateFormat('MM/dd/yyyy').format(now);
    final dayName = DateFormat('EEEE').format(now);
    final time = DateFormat('HH:mm').format(now);

    final records = await getAttendanceRecords();
    final existingRecordIndex = records.indexWhere(
      (record) => record.date == date,
    );

    AttendanceRecord newRecord;

    if (existingRecordIndex != -1) {
      // Update existing record
      final existingRecord = records[existingRecordIndex];
      newRecord = existingRecord.copyWith(
        checkInTime: time,
        status: AttendanceRecord.calculateStatus(
          time,
          existingRecord.checkOutTime,
        ),
      );
      records[existingRecordIndex] = newRecord;
    } else {
      // Create new record
      newRecord = AttendanceRecord(
        date: date,
        dayName: dayName,
        checkInTime: time,
        status: AttendanceRecord.calculateStatus(time, null),
      );
      records.add(newRecord);
    }

    await saveAttendanceRecords(records);
    return newRecord;
  }

  // Check out
  static Future<AttendanceRecord> checkOut() async {
    final now = DateTime.now();
    final date = DateFormat('MM/dd/yyyy').format(now);
    final dayName = DateFormat('EEEE').format(now);
    final time = DateFormat('HH:mm').format(now);

    final records = await getAttendanceRecords();
    final existingRecordIndex = records.indexWhere(
      (record) => record.date == date,
    );

    AttendanceRecord newRecord;

    if (existingRecordIndex != -1) {
      // Update existing record
      final existingRecord = records[existingRecordIndex];
      newRecord = existingRecord.copyWith(
        checkOutTime: time,
        status: AttendanceRecord.calculateStatus(
          existingRecord.checkInTime,
          time,
        ),
      );
      records[existingRecordIndex] = newRecord;
    } else {
      // Create new record (unusual case - checkout without checkin)
      newRecord = AttendanceRecord(
        date: date,
        dayName: dayName,
        checkOutTime: time,
        status: AttendanceRecord.calculateStatus(null, time),
      );
      records.add(newRecord);
    }

    await saveAttendanceRecords(records);
    return newRecord;
  }

  // Simulate error for testing
  static Future<void> simulateError() async {
    throw Exception('Simulated error during save/load operation');
  }
}
