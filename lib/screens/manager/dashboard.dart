import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../backend/services/database_service.dart';
import '../../backend/services/hardware_simulator_service.dart';
import '../../backend/services/attendance_processor_service.dart';

class ManagerDashboard extends StatefulWidget {
  const ManagerDashboard({Key? key}) : super(key: key);

  @override
  _ManagerDashboardState createState() => _ManagerDashboardState();
}

class _ManagerDashboardState extends State<ManagerDashboard> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Start listening to raw hardware access logs
    AttendanceProcessorService().startListening();
  }

  void _showSimulationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Simulate Hardware Access', style: TextStyle(fontFamily: 'Inter')),
          content: SizedBox(
            width: double.maxFinite,
            height: 300,
            child: StreamBuilder<QuerySnapshot>(
              stream: DatabaseService().employeesStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                final employees = snapshot.data!.docs;
                if (employees.isEmpty) return const Text('No employees found.');
                
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: employees.length,
                  itemBuilder: (context, index) {
                    final data = employees[index].data() as Map<String, dynamic>;
                    return ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.person)),
                      title: Text(data['fullName'] ?? 'Unknown'),
                      subtitle: Text(data['department'] ?? ''),
                      onTap: () {
                        HardwareSimulatorService().simulateAccess(data['uid'], data['fullName']);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Access logged for ${data['fullName']}'), backgroundColor: Colors.green),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatCard(String title, String count, IconData icon, Color iconColor) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F7FA),
          borderRadius: BorderRadius.circular(8),
          border: const Border(
            left: BorderSide(color: Color(0xFF1A73E8), width: 4),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: iconColor, size: 20),
            const SizedBox(height: 8),
            Text(
              count,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A73E8),
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontFamily: 'Inter',
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityRow(String name, String time, String status, Color statusColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFE8F0FE),
            child: Text(
              name[0],
              style: const TextStyle(color: Color(0xFF1A73E8), fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                ),
                Text(
                  time,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: statusColor,
                fontSize: 12,
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
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/logo.png',
            color: Colors.white,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.security, color: Colors.white),
          ),
        ),
        actions: [
          const Center(
            child: Text(
              'Ali Khan',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
              ),
            ),
          ),
          const SizedBox(width: 8),
          const CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.person, color: Color(0xFF1A73E8)),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Good Morning, Ali',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                _buildStatCard('Total\nEmployees', '124', Icons.people, Colors.black54),
                _buildStatCard('Present\nToday', '118', Icons.circle, Colors.green),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildStatCard('Absent\nToday', '4', Icons.circle, Colors.red),
                _buildStatCard('Late\nArrivals', '2', Icons.access_time_filled, Colors.orange),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              'Recent Activity',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 16),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('access_logs')
                  .orderBy('timestamp', descending: true)
                  .limit(10)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                final logs = snapshot.data!.docs;
                if (logs.isEmpty) return const Text('No recent activity');
                return Column(
                  children: logs.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    final ts = data['timestamp'] as Timestamp?;
                    final timeStr = ts != null ? TimeOfDay.fromDateTime(ts.toDate()).format(context) : 'Just now';
                    return _buildActivityRow(data['employeeName'] ?? 'Unknown', timeStr, 'Present', Colors.green);
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showSimulationDialog(context),
        backgroundColor: const Color(0xFF1A73E8),
        icon: const Icon(Icons.nfc),
        label: const Text('Simulate Access', style: TextStyle(fontFamily: 'Inter')),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          // Handle navigation
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF1A73E8),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Employees'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Attendance'),
          BottomNavigationBarItem(icon: Icon(Icons.attach_money), label: 'Payroll'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
