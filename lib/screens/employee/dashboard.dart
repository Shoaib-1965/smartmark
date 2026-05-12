import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../../backend/services/database_service.dart';

class EmployeeDashboard extends StatefulWidget {
  const EmployeeDashboard({super.key});

  @override
  State<EmployeeDashboard> createState() => _EmployeeDashboardState();
}

class _EmployeeDashboardState extends State<EmployeeDashboard> {
  int _selectedIndex = 0;

  Widget _buildStatCard(String title, String count, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
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
                color: color.withValues(alpha: 0.8),
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentAttendanceRow(String date, String checkIn, String checkOut) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            date,
            style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Inter'),
          ),
          Row(
            children: [
              const Icon(Icons.login, size: 14, color: Colors.green),
              const SizedBox(width: 4),
              Text(checkIn, style: const TextStyle(fontSize: 13, fontFamily: 'Inter')),
              const SizedBox(width: 16),
              const Icon(Icons.logout, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Text(checkOut, style: const TextStyle(fontSize: 13, fontFamily: 'Inter')),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return const Scaffold(body: Center(child: Text('Not logged in')));

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
          StreamBuilder<DocumentSnapshot>(
            stream: DatabaseService().getUserStream(user.uid),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const SizedBox();
              final data = snapshot.data!.data() as Map<String, dynamic>?;
              final name = data != null ? (data['fullName'] ?? 'Employee') : 'Employee';
              return Center(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                ),
              );
            }
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
            StreamBuilder<DocumentSnapshot>(
              stream: DatabaseService().getUserStream(user.uid),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const SizedBox();
                final data = snapshot.data!.data() as Map<String, dynamic>?;
                final name = data != null ? (data['fullName']?.split(' ')[0] ?? 'There') : 'There';
                return Text(
                  'Good Morning, $name',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Inter',
                  ),
                );
              }
            ),
            const SizedBox(height: 24),
            
            // Today's Status Card
            StreamBuilder<DocumentSnapshot>(
              stream: DatabaseService().getTodayAttendance(user.uid, DateFormat('yyyy-MM-dd').format(DateTime.now())),
              builder: (context, snapshot) {
                String checkIn = '--:--';
                String checkOut = 'Not yet';

                if (snapshot.hasData && snapshot.data!.exists) {
                  final data = snapshot.data!.data() as Map<String, dynamic>?;
                  if (data != null) {
                    if (data['checkIn'] != null) {
                      checkIn = TimeOfDay.fromDateTime((data['checkIn'] as Timestamp).toDate()).format(context);
                    }
                    if (data['checkOut'] != null) {
                      checkOut = TimeOfDay.fromDateTime((data['checkOut'] as Timestamp).toDate()).format(context);
                    }
                  }
                }

                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF1A73E8), width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1A73E8).withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Today\'s Status',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Check-in', style: TextStyle(color: Colors.grey, fontSize: 12, fontFamily: 'Inter')),
                              const SizedBox(height: 4),
                              Text(checkIn, style: const TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text('Check-out', style: TextStyle(color: Colors.grey, fontSize: 12, fontFamily: 'Inter')),
                              const SizedBox(height: 4),
                              Text(checkOut, style: const TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
            ),
            
            const SizedBox(height: 24),
            
            // Summary Cards
            const Text(
              'This Month',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 12),
            StreamBuilder<QuerySnapshot>(
              stream: DatabaseService().getMyAttendance(user.uid),
              builder: (context, snapshot) {
                int present = 0;
                int late = 0;
                
                if (snapshot.hasData) {
                  final monthStr = DateFormat('yyyy-MM').format(DateTime.now());
                  for (var doc in snapshot.data!.docs) {
                    final data = doc.data() as Map<String, dynamic>;
                    if ((data['date'] as String).startsWith(monthStr)) {
                      if (data['status'] == 'Present') present++;
                      if (data['status'] == 'Late') late++;
                    }
                  }
                }
                
                return Row(
                  children: [
                    _buildStatCard('Present', '$present', const Color(0xFF1A73E8)),
                    _buildStatCard('Absent', '0', Colors.red),
                    _buildStatCard('Late', '$late', Colors.orange),
                  ],
                );
              }
            ),
            
            const SizedBox(height: 24),
            
            // Salary Preview Card
            StreamBuilder<DocumentSnapshot>(
              stream: DatabaseService().getUserStream(user.uid),
              builder: (context, snapshot) {
                double hourlyRate = 0;
                if (snapshot.hasData && snapshot.data!.exists) {
                  final data = snapshot.data!.data() as Map<String, dynamic>?;
                  hourlyRate = (data?['hourlyRate'] ?? 0.0).toDouble();
                }

                return StreamBuilder<QuerySnapshot>(
                  stream: DatabaseService().getMyAttendance(user.uid),
                  builder: (context, attSnapshot) {
                    double totalHours = 0;
                    if (attSnapshot.hasData) {
                      final monthStr = DateFormat('yyyy-MM').format(DateTime.now());
                      for (var doc in attSnapshot.data!.docs) {
                        final data = doc.data() as Map<String, dynamic>;
                        if ((data['date'] as String).startsWith(monthStr)) {
                          totalHours += (data['totalHours'] ?? 0.0).toDouble();
                        }
                      }
                    }

                    double estSalary = totalHours * hourlyRate;

                    return Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade200),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'This Month Salary (Est.)',
                                style: TextStyle(color: Colors.grey, fontSize: 14, fontFamily: 'Inter'),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'PKR ${estSalary.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  color: Color(0xFF1A73E8),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F0FE),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.payments, color: Color(0xFF1A73E8)),
                          ),
                        ],
                      ),
                    );
                  }
                );
              }
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
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('attendance')
                  .where('employeeId', isEqualTo: user.uid)
                  .orderBy('date', descending: true)
                  .limit(5)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                final docs = snapshot.data!.docs;
                if (docs.isEmpty) return const Text('No attendance records found');
                
                return Column(
                  children: docs.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    
                    String checkInStr = '--:--';
                    String checkOutStr = '--:--';
                    
                    if (data['checkIn'] != null) {
                      checkInStr = TimeOfDay.fromDateTime((data['checkIn'] as Timestamp).toDate()).format(context);
                    }
                    if (data['checkOut'] != null) {
                      checkOutStr = TimeOfDay.fromDateTime((data['checkOut'] as Timestamp).toDate()).format(context);
                    }

                    // Format date
                    final dateParsed = DateFormat('yyyy-MM-dd').parse(data['date']);
                    final dateDisplay = DateFormat('MMM dd').format(dateParsed);

                    return Column(
                      children: [
                        _buildRecentAttendanceRow(dateDisplay, checkInStr, checkOutStr),
                        if (doc.id != docs.last.id) const Divider(),
                      ],
                    );
                  }).toList(),
                );
              }
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF1A73E8),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Attendance'),
          BottomNavigationBarItem(icon: Icon(Icons.attach_money), label: 'Salary'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
