import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../backend/services/auth_service.dart';

class AddEmployeePage extends StatefulWidget {
  const AddEmployeePage({super.key});

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  final _formKey = GlobalKey<FormState>();
  
  String? _role = 'Employee';
  String? _department = 'IT';
  
  final _nameCtrl = TextEditingController();
  final _cnicCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _rateCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  File? _imageFile;
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  Future<String> _uploadImage(String email) async {
    if (_imageFile == null) return '';
    try {
      final ref = FirebaseStorage.instance.ref().child('profiles/$email.jpg');
      await ref.putFile(_imageFile!);
      return await ref.getDownloadURL();
    } catch (e) {
      print('Upload error: $e');
      return '';
    }
  }

  Widget _buildTextField(String label, TextEditingController controller, {IconData? suffixIcon, bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        validator: (val) => val == null || val.isEmpty ? 'Required' : null,
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

  Future<void> _saveEmployee() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    String photoUrl = await _uploadImage(_emailCtrl.text.trim());

    bool success = await AuthService().createEmployee(
      email: _emailCtrl.text.trim(),
      password: _passwordCtrl.text.trim(),
      fullName: _nameCtrl.text.trim(),
      cnic: _cnicCtrl.text.trim(),
      department: _department ?? 'IT',
      hourlyRate: double.tryParse(_rateCtrl.text.trim()) ?? 0.0,
      photoUrl: photoUrl,
    );

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Employee Added Successfully'), backgroundColor: Colors.green),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add employee'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A73E8),
        elevation: 0,
        title: const Text(
          'Add New Employee',
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
                  onTap: _pickImage,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF1A73E8),
                        width: 2,
                      ),
                      color: const Color(0xFFE8F0FE),
                      image: _imageFile != null
                          ? DecorationImage(image: FileImage(_imageFile!), fit: BoxFit.cover)
                          : null,
                    ),
                    child: _imageFile == null
                        ? const Icon(Icons.camera_alt, color: Color(0xFF1A73E8), size: 40)
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              _buildTextField('Full Name', _nameCtrl),
              _buildTextField('CNIC Number', _cnicCtrl, isNumber: true),
              _buildTextField('Email', _emailCtrl),
              _buildDropdownField('Role', ['Employee', 'Manager'], _role, (val) => setState(() => _role = val)),
              _buildDropdownField('Department', ['IT', 'HR', 'Sales', 'Marketing', 'Design'], _department, (val) => setState(() => _department = val)),
              _buildTextField('Hourly Rate (PKR)', _rateCtrl, isNumber: true),
              
              const SizedBox(height: 16),
              const Text(
                'Credentials',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Inter'),
              ),
              const SizedBox(height: 16),
              _buildTextField('Password', _passwordCtrl),

              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _isLoading ? null : _saveEmployee,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A73E8),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Save Employee',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Inter'),
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
