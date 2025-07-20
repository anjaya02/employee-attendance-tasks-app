# Employee Attendance & Daily Tasks App

A Flutter-based mobile application for employees to log attendance (Check In/Check Out) and manage daily tasks with local data persistence.

## Features

### Attendance Management

- **Employee Name Registration**: Enter name once, persists across sessions
- **Check-In/Check-Out**: Record timestamps in device local time
- **Real-time Display**: Shows today's record with:
  - Date (MM/DD/YYYY format using device locale)
  - Day name (e.g., "Monday")
  - Check-In time (HH:mm format)
  - Check-Out time (HH:mm format)
  - Time spent (difference between Check-Out and Check-In in HH:mm)
  - Attendance Status:
    - **Present**: Both Check-In and Check-Out exist
    - **Incomplete**: Only Check-In or only Check-Out exists
    - **Absent**: No record for the day
- **History View**: View past attendance records
- **Edge Case Handling**: Incomplete records persist while allowing new day check-ins

### Task Management

- **Task Creation**: Add tasks with:
  - Name (short description)
  - Due Date (date picker, MM/DD/YYYY format)
  - Priority (Low/Medium/High)
  - Status (Not Started/In Progress/Done)
- **Status Updates**: Easily update task status
- **Persistent Storage**: All tasks survive app restarts and hot-reloads
- **Empty State**: Clean interface when no tasks exist

### Technical Features

- **Local Data Persistence**: Uses SharedPreferences for reliable data storage
- **Error Handling**: User-friendly error messages and loading indicators
- **Debug Error Simulation**: Hidden "Simulate Error" feature (long-press app title)
- **Cross-Platform**: Supports Web and Android platforms
- **Material Design**: Clean UI using standard Flutter widgets

## How to Run

### Prerequisites

- Flutter SDK (3.8.1 or higher)
- Dart SDK
- For Android: Android Studio with SDK
- For Web: Chrome browser

### Installation & Setup

1. Clone or download this repository
2. Navigate to the project directory
3. Install dependencies:
   ```bash
   flutter pub get
   ```

### Running on Web

```bash
flutter run -d web-server
```

The app will be available at `http://localhost:port` (port will be displayed in terminal)

### Running on Android

1. Connect an Android device or start an emulator
2. Run:
   ```bash
   flutter run
   ```

### Building APK

```bash
flutter build apk --release
```

The APK will be generated in `build/app/outputs/flutter-apk/app-release.apk`

## Technology Choices

### Dependencies

- **shared_preferences (^2.2.2)**: Chosen for local data persistence due to:

  - Simple key-value storage perfect for app settings and small data
  - Cross-platform compatibility
  - Reliable persistence across app sessions
  - No complex database setup required

- **intl (^0.19.0)**: Selected for date/time formatting because:
  - Comprehensive internationalization support
  - Consistent date formatting across platforms
  - Built-in locale handling
  - Standard Flutter package for date operations

### Architecture Decisions

- **Service Layer Pattern**: Separated business logic (AttendanceService, TaskService) from UI
- **Model Classes**: Clean data models with JSON serialization for easy storage
- **Stateful Widgets**: Used for screens requiring dynamic data updates
- **Bottom Navigation**: Intuitive navigation pattern for mobile apps

### UI/UX Choices

- **Material Design 3**: Modern, accessible design system
- **Card-based Layout**: Clear visual separation of information
- **Color-coded Status**: Immediate visual feedback for attendance and task status
- **Form Validation**: Prevents invalid data entry
- **Loading States**: Clear feedback during async operations

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   ├── attendance_record.dart # Attendance data model
│   └── task.dart             # Task data model
├── services/
│   ├── attendance_service.dart # Attendance business logic
│   └── task_service.dart      # Task business logic
└── screens/
    ├── home_screen.dart       # Main navigation
    ├── attendance_screen.dart # Attendance management
    ├── tasks_screen.dart      # Task management
    └── about_screen.dart      # App information
```

## Testing the App

### Attendance Flow

1. Launch app → Enter name if prompted
2. Tap "Check In" → Verify timestamp (date, day, time)
3. Tap "Check Out" → Verify out-time, time-spent, and status = "Present"
4. Close & re-open → Verify today's record persists
5. Long-press title → Tap "Simulate Error" → Verify error message

### Tasks Flow

1. Switch to Tasks → Verify empty list on first launch
2. Add a task (Name, Due Date, Priority, Status) → Verify it appears
3. Change Status → Verify update persists after restart

### Edge Cases

- Don't Check Out → Status = "Incomplete"
- No Check In/Out for a day → Status = "Absent"
- Incomplete record remains visible in history

## Assumptions & Design Decisions

### Assumptions Made

- Single user per device (no multi-user authentication)
- Device time zone is correct for attendance tracking
- Tasks are personal (no sharing/collaboration features)
- Local storage is sufficient (no cloud sync required)

### Bonus Features Added

- About screen with app information and instructions
- Visual status indicators with color coding
- Comprehensive error handling throughout the app
- Clean empty states for better UX
- Detailed attendance history view

## Development Time

**Total Time Taken**: Approximately 4-6 hours

- Initial setup and dependencies: 30 minutes
- Data models and services: 1.5 hours
- UI implementation: 2.5 hours
- Testing and bug fixes: 1 hour
- Documentation: 30 minutes

## Developer Information

- **Developer**: Anjaya Induwara
- **Contact**: +94 711687980
- **Email**: anjayainduwara@gmail.com
- **Build Date**: July 20, 2025
- **Version**: 1.0.0
- **Platform**: Flutter

## Future Enhancements

- Export attendance data to CSV
- Task categories and filtering
- Reminder notifications for tasks
- Dark theme support
- Cloud synchronization
- Multi-language support

---

For any issues or questions, please refer to the About screen in the app or check the Flutter documentation at https://docs.flutter.dev/
