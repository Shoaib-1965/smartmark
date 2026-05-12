import 'package:flutter/material.dart';

class ManagerAttendancePage extends StatefulWidget {
  const ManagerAttendancePage({Key? key}) : super(key: key);

  @override
  _ManagerAttendancePageState createState() => _ManagerAttendancePageState();
}

class _ManagerAttendancePageState extends State<ManagerAttendancePage> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Present', 'Absent', 'Late'];
  int _selectedDateIndex = 2; // Simulating 'today'

  Widget _buildFilterChip(String label) {
    bool isSelected = _selectedFilter == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (bool selected) {
          setState(() {
            if (selected) _selectedFilter = label;
          });
        },
        selectedColor: const Color(0xFF1A73E8),
        backgroundColor: Colors.white,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected ? const Color(0xFF1A73E8) : Colors.grey.shade300,
          ),
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    return Container(
      color: const Color(0xFFF5F7FA),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: List.generate(7, (index) {
            bool isSelected = index == _selectedDateIndex;
            return GestureDetector(
              onTap: () => setState(() => _selectedDateIndex = index),
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF1A73E8) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: isSelected ? Colors.transparent : Colors.grey.shade300),
                ),
                child: Column(
                  children: [
                    Text(
                      'Oct ${10 + index}',
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildAttendanceRow(String name, String checkIn, String checkOut, String hours, String status, Color statusColor, bool isEven) {
    return Container(
      color: isEven ? Colors.white : const Color(0xFFF5F7FA),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: const Color(0xFFE8F0FE),
            child: Text(
              name[0],
              style: const TextStyle(color: Color(0xFF1A73E8), fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Inter', fontSize: 13),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(checkIn, style: const TextStyle(fontSize: 12, fontFamily: 'Inter')),
                Text(checkOut, style: const TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'Inter')),
              ],
            ),
          ),
          Expanded(
            child: Text(hours, style: const TextStyle(fontSize: 13, fontFamily: 'Inter')),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
          'Attendance Records',
          style: TextStyle(color: Colors.white, fontFamily: 'Inter'),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.download, color: Colors.white, size: 18),
            label: const Text('Export CSV', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildDateSelector(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _filters.map((filter) => _buildFilterChip(filter)).toList(),
              ),
            ),
          ),
          Container(
            color: Colors.grey.shade100,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: const [
                SizedBox(width: 44),
                Expanded(flex: 2, child: Text('Employee', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey))),
                Expanded(child: Text('Time', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey))),
                Expanded(child: Text('Hours', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey))),
                Text('Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildAttendanceRow('Sarah Ahmed', '08:55 AM', '06:00 PM', '9.1', 'Present', Colors.green, true),
                _buildAttendanceRow('Usman Tariq', '09:15 AM', '06:05 PM', '8.8', 'Late', Colors.orange, false),
                _buildAttendanceRow('Zainab Ali', '--:-- AM', '--:-- PM', '0.0', 'Absent', Colors.red, true),
                _buildAttendanceRow('Omar Farooq', '08:50 AM', '06:10 PM', '9.3', 'Present', Colors.green, false),
                _buildAttendanceRow('Aisha Khan', '09:00 AM', '06:00 PM', '9.0', 'Present', Colors.green, true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
