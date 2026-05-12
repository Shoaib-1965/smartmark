import 'package:flutter/material.dart';

class EmployeeProfilePage extends StatelessWidget {
  const EmployeeProfilePage({Key? key}) : super(key: key);

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontFamily: 'Inter',
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
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
          'Profile',
          style: TextStyle(color: Colors.white, fontFamily: 'Inter'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: const Color(0xFF1A73E8),
              padding: const EdgeInsets.only(bottom: 40, top: 20),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
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
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF1A73E8), width: 2),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Color(0xFF1A73E8),
                          size: 20,
                        ),
                      ),
                    ],
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      children: [
                        _buildInfoRow('Full Name', 'Sarah Ahmed'),
                        const Divider(height: 1),
                        _buildInfoRow('CNIC Number', '42101-1234567-8'),
                        const Divider(height: 1),
                        _buildInfoRow('Email', 'sarah.ahmed@example.com'),
                        const Divider(height: 1),
                        _buildInfoRow('Department', 'IT'),
                        const Divider(height: 1),
                        _buildInfoRow('Role', 'Employee'),
                        const Divider(height: 1),
                        _buildInfoRow('Join Date', 'Jan 15, 2023'),
                        const Divider(height: 1),
                        _buildInfoRow('Hourly Rate', 'PKR 1,500'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to edit profile
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A73E8),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
