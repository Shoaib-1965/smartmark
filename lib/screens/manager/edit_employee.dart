import 'package:flutter/material.dart';

class EditEmployeePage extends StatefulWidget {
  const EditEmployeePage({Key? key}) : super(key: key);

  @override
  _EditEmployeePageState createState() => _EditEmployeePageState();
}

class _EditEmployeePageState extends State<EditEmployeePage> {
  final _formKey = GlobalKey<FormState>();
  
  String? _role = 'Employee';
  String? _department = 'IT';

  Widget _buildTextField(String label, {IconData? suffixIcon, String? initialValue}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF1A73E8), width: 2),
          ),
          floatingLabelStyle: const TextStyle(color: Color(0xFF1A73E8)),
          suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: const Color(0xFF1A73E8)) : null,
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, List<String> items, String? value, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF1A73E8), width: 2),
          ),
          floatingLabelStyle: const TextStyle(color: Color(0xFF1A73E8)),
        ),
        value: value,
        items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
        onChanged: onChanged,
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
          'Edit Employee',
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
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Handle photo upload
                  },
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFE8F0FE),
                        ),
                        child: const Center(
                          child: Text(
                            'SA',
                            style: TextStyle(
                              fontSize: 40,
                              color: Color(0xFF1A73E8),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Color(0xFF1A73E8),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              _buildTextField('Full Name', initialValue: 'Sarah Ahmed'),
              _buildTextField('CNIC Number', initialValue: '42101-1234567-8'),
              _buildTextField('Email', initialValue: 'sarah.ahmed@example.com'),
              _buildDropdownField('Role', ['Employee', 'Manager'], _role, (val) => setState(() => _role = val)),
              _buildDropdownField('Department', ['IT', 'HR', 'Sales', 'Marketing', 'Design'], _department, (val) => setState(() => _department = val)),
              _buildTextField('Hourly Rate (PKR)', initialValue: '1500'),
              _buildTextField('RFID Card UID', initialValue: 'A4:B5:C6:D7', suffixIcon: Icons.nfc),
              
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  // Update employee
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
                  'Update Employee',
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
      ),
    );
  }
}
