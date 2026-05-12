import 'package:flutter/material.dart';

class PayrollPage extends StatefulWidget {
  const PayrollPage({Key? key}) : super(key: key);

  @override
  _PayrollPageState createState() => _PayrollPageState();
}

class _PayrollPageState extends State<PayrollPage> {
  String _selectedMonth = 'October 2023';

  Widget _buildPayrollCard(String name, String days, String hours, String rate, String salary, bool isPaid) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: InkWell(
        onTap: () {},
        hoverColor: const Color(0xFFE8F0FE),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
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
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isPaid ? Colors.blue.withOpacity(0.1) : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      isPaid ? 'Paid' : 'Unpaid',
                      style: TextStyle(
                        color: isPaid ? const Color(0xFF1A73E8) : Colors.grey.shade700,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Present', style: TextStyle(color: Colors.grey, fontSize: 12, fontFamily: 'Inter')),
                      Text('$days Days', style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Inter')),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Total Hours', style: TextStyle(color: Colors.grey, fontSize: 12, fontFamily: 'Inter')),
                      Text(hours, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Inter')),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Rate/hr', style: TextStyle(color: Colors.grey, fontSize: 12, fontFamily: 'Inter')),
                      Text('PKR $rate', style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Inter')),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(height: 1),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'PKR $salary',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A73E8),
                      fontFamily: 'Inter',
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.download, size: 16, color: Color(0xFF1A73E8)),
                    label: const Text('Payslip', style: TextStyle(color: Color(0xFF1A73E8), fontSize: 12)),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF1A73E8)),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
          'Payroll',
          style: TextStyle(color: Colors.white, fontFamily: 'Inter'),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, color: Color(0xFF1A73E8), size: 20),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: _selectedMonth,
                  underline: const SizedBox(),
                  icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF1A73E8)),
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
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Total Payroll Amount',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontFamily: 'Inter',
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'PKR 450,000',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.payments, color: Colors.white, size: 32),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildPayrollCard('Sarah Ahmed', '20', '180.5', '1500', '270,750', true),
                _buildPayrollCard('Usman Tariq', '19', '170.0', '1200', '204,000', false),
                _buildPayrollCard('Zainab Ali', '21', '189.0', '1800', '340,200', true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
