import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentDate = DateFormat('MMMM dd, yyyy').format(DateTime.now());

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('About', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 24),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.business, size: 24, color: Colors.blue),
                      SizedBox(width: 8),
                      Text(
                        'Employee Attendance & Tasks',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow('Version', '1.0.0'),
                  _buildInfoRow('Developer', 'Anjaya Induwara'),
                  _buildInfoRow('Contact', '+94 711687980'),
                  _buildInfoRow('Email', 'anjayainduwara@gmail.com'),
                  _buildInfoRow('Build Date', currentDate),
                  _buildInfoRow('Platform', 'Flutter'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.info, size: 24, color: Colors.green),
                      SizedBox(width: 8),
                      Text(
                        'App Features',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildFeature('✓ Check-in and Check-out with timestamps'),
                  _buildFeature('✓ Automatic attendance status calculation'),
                  _buildFeature('✓ Daily task management with priorities'),
                  _buildFeature(
                    '✓ Task status tracking (Not Started, In Progress, Done)',
                  ),
                  _buildFeature('✓ Local data persistence'),
                  _buildFeature('✓ Error handling and user feedback'),
                  _buildFeature('✓ Web and Android support'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.help, size: 24, color: Colors.orange),
                      SizedBox(width: 8),
                      Text(
                        'How to Use',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildInstructionStep('1. Enter your name when prompted'),
                  _buildInstructionStep(
                    '2. Use Check In/Check Out buttons to record attendance',
                  ),
                  _buildInstructionStep(
                    '3. Add daily tasks with due dates and priorities',
                  ),
                  _buildInstructionStep(
                    '4. Update task status as you progress',
                  ),
                  _buildInstructionStep(
                    '5. View your attendance history and task list',
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Debug Feature: Long press the app title to simulate an error for testing.',
                    style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 32),

          Center(
            child: Text(
              '© 2025 Employee Attendance & Tasks App\nDeveloped by Anjaya Induwara',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildFeature(String feature) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Text(feature, style: const TextStyle(fontSize: 14)),
    );
  }

  Widget _buildInstructionStep(String step) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Text(step, style: const TextStyle(fontSize: 14)),
    );
  }
}
