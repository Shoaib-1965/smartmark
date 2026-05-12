import 'package:flutter/material.dart';

class EmployeeDetailPage extends StatelessWidget {
  const EmployeeDetailPage({Key? key}) : super(key: key);

  Widget _buildInfoRow(String label, String value, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, color: Colors.grey, size: 20),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceStat(String title, String count, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Text(
              count,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: color.withOpacity(0.8),
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentAttendanceRow(String date, String checkIn, String checkOut, String hours, String status, Color statusColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F7FA),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(
                  date.split(' ')[0],
                  style: const TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'Inter'),
                ),
                Text(
                  date.split(' ')[1],
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Inter'),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.login, size: 14, color: Colors.green),
                    const SizedBox(width: 4),
                    Text(checkIn, style: const TextStyle(fontSize: 13, fontFamily: 'Inter')),
                    const SizedBox(width: 12),
                    const Icon(Icons.logout, size: 14, color: Colors.red),
                    const SizedBox(width: 4),
                    Text(checkOut, style: const TextStyle(fontSize: 13, fontFamily: 'Inter')),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '$hours hrs total',
                  style: const TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'Inter'),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: statusColor,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A73E8),
        elevation: 0,
        title: const Text(
          'Sarah Ahmed',
          style: TextStyle(color: Colors.white, fontFamily: 'Inter'),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (Navigator.canPop(context)) Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Blue Card
            Container(
              color: const Color(0xFF1A73E8),
              padding: const EdgeInsets.only(bottom: 32, top: 16),
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                      color: const Color(0xFFE8F0FE),
                    ),
                    child: const Center(
                      child: Text(
                        'SA',
                        style: TextStyle(
                          fontSize: 36,
                          color: Color(0xFF1A73E8),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Sarah Ahmed',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Software Engineer • IT',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Joined: Jan 15, 2023',
                      style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'Inter'),
                    ),
                  ),
                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Personal Info
                  const Text(
                    'Personal Information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      children: [
                        _buildInfoRow('CNIC Number', '42101-1234567-8', icon: Icons.badge),
                        const Divider(height: 1),
                        _buildInfoRow('Email Address', 'sarah.ahmed@example.com', icon: Icons.email),
                        const Divider(height: 1),
                        _buildInfoRow('RFID Card UID', 'A4:B5:C6:D7', icon: Icons.nfc),
                        const Divider(height: 1),
                        _buildInfoRow('Hourly Rate', 'PKR 1,500/hr', icon: Icons.payments),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Attendance Summary
                  const Text(
                    'This Month',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildAttendanceStat('Present', '18', const Color(0xFF1A73E8)),
                      _buildAttendanceStat('Absent', '2', Colors.red),
                      _buildAttendanceStat('Late', '1', Colors.orange),
                    ],
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Recent Attendance
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Recent Attendance',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('View All', style: TextStyle(color: Color(0xFF1A73E8))),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildRecentAttendanceRow('Oct 12', '08:55 AM', '06:05 PM', '9.1', 'Present', Colors.green),
                  _buildRecentAttendanceRow('Oct 11', '09:15 AM', '06:00 PM', '8.7', 'Late', Colors.orange),
                  _buildRecentAttendanceRow('Oct 10', '--:-- AM', '--:-- PM', '0.0', 'Absent', Colors.red),
                  
                  const SizedBox(height: 40),
                  
                  // Actions
                  OutlinedButton.icon(
                    onPressed: () {
                      // Navigate to edit
                    },
                    icon: const Icon(Icons.edit, color: Color(0xFF1A73E8)),
                    label: const Text('Edit Employee', style: TextStyle(color: Color(0xFF1A73E8))),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF1A73E8)),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () {
                      // Handle delete
                    },
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    label: const Text('Delete Employee', style: TextStyle(color: Colors.red)),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
