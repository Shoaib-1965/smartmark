import 'package:flutter/material.dart';

class EmployeeSalaryPage extends StatefulWidget {
  const EmployeeSalaryPage({Key? key}) : super(key: key);

  @override
  _EmployeeSalaryPageState createState() => _EmployeeSalaryPageState();
}

class _EmployeeSalaryPageState extends State<EmployeeSalaryPage> {
  String _selectedMonth = 'October 2023';

  Widget _buildBreakdownRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.grey, fontFamily: 'Inter'),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Inter'),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(String month, String amount) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F0FE),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.calendar_month, color: Color(0xFF1A73E8), size: 20),
                ),
                const SizedBox(width: 16),
                Text(
                  month,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Inter', fontSize: 16),
                ),
              ],
            ),
            Text(
              'PKR $amount',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A73E8),
                fontFamily: 'Inter',
                fontSize: 16,
              ),
            ),
          ],
        ),
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
          'My Salary',
          style: TextStyle(color: Colors.white, fontFamily: 'Inter'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedMonth,
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF1A73E8)),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      if (newValue != null) _selectedMonth = newValue;
                    });
                  },
                  items: <String>['August 2023', 'September 2023', 'October 2023']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF1A73E8),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1A73E8).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  Text(
                    'Total Salary',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontFamily: 'Inter',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'PKR 270,750',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Salary Breakdown',
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
                  _buildBreakdownRow('Total Working Days', '22'),
                  const Divider(height: 1),
                  _buildBreakdownRow('Days Present', '20'),
                  const Divider(height: 1),
                  _buildBreakdownRow('Total Hours Worked', '180.5'),
                  const Divider(height: 1),
                  _buildBreakdownRow('Hourly Rate (PKR)', '1,500'),
                  const Divider(height: 1),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Gross Salary',
                          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Inter', fontSize: 16),
                        ),
                        Text(
                          'PKR 270,750',
                          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Inter', fontSize: 16, color: Color(0xFF1A73E8)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Salary History',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 16),
            _buildHistoryCard('September 2023', '265,000'),
            _buildHistoryCard('August 2023', '270,000'),
            _buildHistoryCard('July 2023', '255,500'),
          ],
        ),
      ),
    );
  }
}
