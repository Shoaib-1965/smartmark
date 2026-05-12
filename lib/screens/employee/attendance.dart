import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import '../../backend/services/database_service.dart';

class EmployeeAttendancePage extends StatefulWidget {
  const EmployeeAttendancePage({super.key});

  @override
  State<EmployeeAttendancePage> createState() => _EmployeeAttendancePageState();
}

class _EmployeeAttendancePageState extends State<EmployeeAttendancePage> {
  String _currentMonth = DateFormat('MMMM yyyy').format(DateTime.now());

  Widget _buildCalendarGrid() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left, color: Color(0xFF1A73E8)),
                onPressed: () {},
              ),
              Text(
                _currentMonth,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right, color: Color(0xFF1A73E8)),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
                .map((day) => Text(
                      day,
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                    ))
                .toList(),
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1.0,
            ),
            itemCount: 31,
            itemBuilder: (context, index) {
              int day = index + 1;
              Color dotColor = Colors.transparent;
              if (day < 10) dotColor = Colors.green;
              if (day == 10) dotColor = Colors.red;
              if (day == 11) dotColor = Colors.orange;
              if (day == 12) dotColor = Colors.green;
              if (day > 12) dotColor = Colors.grey.shade300;

              bool isSelected = day == 12;

              return Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF1A73E8) : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$day',
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 2),
                    if (dotColor != Colors.transparent && !isSelected)
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: dotColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceRow(String date, String day, String checkIn, String checkOut, String hours, String status, Color statusColor, bool isEven) {
    return Container(
      color: isEven ? Colors.white : const Color(0xFFF5F7FA),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(date, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Inter', fontSize: 14)),
                Text(day, style: const TextStyle(color: Colors.grey, fontFamily: 'Inter', fontSize: 12)),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.login, size: 12, color: Colors.green),
                        const SizedBox(width: 4),
                        Text(checkIn, style: const TextStyle(fontSize: 12, fontFamily: 'Inter')),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.logout, size: 12, color: Colors.red),
                        const SizedBox(width: 4),
                        Text(checkOut, style: const TextStyle(fontSize: 12, fontFamily: 'Inter')),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(hours, style: const TextStyle(fontSize: 13, fontFamily: 'Inter')),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
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
          'My Attendance',
          style: TextStyle(color: Colors.white, fontFamily: 'Inter'),
        ),
      ),
      body: Column(
        children: [
          _buildCalendarGrid(),
          Container(
            color: Colors.grey.shade100,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: const [
                Expanded(flex: 2, child: Text('Date', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey))),
                Expanded(flex: 3, child: Text('Time', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey))),
                Expanded(child: Text('Hours', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey))),
                Text('Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: DatabaseService().getMyAttendance(FirebaseAuth.instance.currentUser!.uid),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                final docs = snapshot.data!.docs;
                if (docs.isEmpty) return const Center(child: Text('No attendance records found.'));
                
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index].data() as Map<String, dynamic>;
                    
                    String checkInStr = '--:--';
                    String checkOutStr = '--:--';
                    
                    if (data['checkIn'] != null) {
                      checkInStr = TimeOfDay.fromDateTime((data['checkIn'] as Timestamp).toDate()).format(context);
                    }
                    if (data['checkOut'] != null) {
                      checkOutStr = TimeOfDay.fromDateTime((data['checkOut'] as Timestamp).toDate()).format(context);
                    }

                    final dateParsed = DateFormat('yyyy-MM-dd').parse(data['date']);
                    final dayStr = DateFormat('MMM dd').format(dateParsed);
                    final weekdayStr = DateFormat('EEEE').format(dateParsed);
                    final status = data['status'] ?? 'Present';
                    final hours = (data['totalHours'] ?? 0.0).toStringAsFixed(1);
                    
                    Color statusColor = Colors.green;
                    if (status == 'Late') statusColor = Colors.orange;
                    if (status == 'Absent') statusColor = Colors.red;

                    return _buildAttendanceRow(
                      dayStr, 
                      weekdayStr, 
                      checkInStr, 
                      checkOutStr, 
                      hours, 
                      status, 
                      statusColor, 
                      index != docs.length - 1
                    );
                  },
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}
