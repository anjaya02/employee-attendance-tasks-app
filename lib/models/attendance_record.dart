import 'package:intl/intl.dart';

class AttendanceRecord {
  final String date; // MM/DD/YYYY format
  final String dayName; // e.g., "Monday"
  final String? checkInTime; // HH:mm format
  final String? checkOutTime; // HH:mm format
  final String status; // Present, Incomplete, Absent, On Leave

  AttendanceRecord({
    required this.date,
    required this.dayName,
    this.checkInTime,
    this.checkOutTime,
    required this.status,
  });

  // Calculate time spent between check-in and check-out
  String get timeSpent {
    if (checkInTime == null || checkOutTime == null) {
      return '';
    }

    try {
      final checkIn = DateFormat('HH:mm').parse(checkInTime!);
      final checkOut = DateFormat('HH:mm').parse(checkOutTime!);

      Duration difference = checkOut.difference(checkIn);

      // Handle case where check-out is next day (negative difference)
      if (difference.isNegative) {
        difference = Duration(hours: 24) + difference;
      }

      final hours = difference.inHours;
      final minutes = difference.inMinutes % 60;

      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
    } catch (e) {
      return '';
    }
  }

  // Calculate attendance status based on check-in/check-out data
  static String calculateStatus(String? checkIn, String? checkOut) {
    if (checkIn != null && checkOut != null) {
      return 'Present';
    } else if (checkIn != null || checkOut != null) {
      return 'Incomplete';
    } else {
      return 'Absent';
    }
  }

  // Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'dayName': dayName,
      'checkInTime': checkInTime,
      'checkOutTime': checkOutTime,
      'status': status,
    };
  }

  // Create from JSON
  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    return AttendanceRecord(
      date: json['date'] as String,
      dayName: json['dayName'] as String,
      checkInTime: json['checkInTime'] as String?,
      checkOutTime: json['checkOutTime'] as String?,
      status: json['status'] as String,
    );
  }

  // Create a copy with updated fields
  AttendanceRecord copyWith({
    String? date,
    String? dayName,
    String? checkInTime,
    String? checkOutTime,
    String? status,
  }) {
    return AttendanceRecord(
      date: date ?? this.date,
      dayName: dayName ?? this.dayName,
      checkInTime: checkInTime ?? this.checkInTime,
      checkOutTime: checkOutTime ?? this.checkOutTime,
      status: status ?? this.status,
    );
  }
}
