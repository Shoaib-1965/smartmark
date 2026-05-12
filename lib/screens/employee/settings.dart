import 'package:flutter/material.dart';

class EmployeeSettingsPage extends StatefulWidget {
  const EmployeeSettingsPage({Key? key}) : super(key: key);

  @override
  _EmployeeSettingsPageState createState() => _EmployeeSettingsPageState();
}

class _EmployeeSettingsPageState extends State<EmployeeSettingsPage> {
  bool _notificationsEnabled = true;

  Widget _buildListTile(String title, IconData icon, {Widget? trailing, VoidCallback? onTap, Color? iconColor, Color? titleColor}) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (iconColor ?? const Color(0xFF1A73E8)).withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor ?? const Color(0xFF1A73E8), size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
          color: titleColor ?? Colors.black87,
        ),
      ),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
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
          'Settings',
          style: TextStyle(color: Colors.white, fontFamily: 'Inter'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/logo.png',
                    width: 60,
                    height: 60,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.security, size: 60, color: Color(0xFF1A73E8)),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'SmartMark v1.0.0',
                    style: TextStyle(color: Colors.grey, fontFamily: 'Inter'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  _buildListTile('Edit Profile', Icons.edit, onTap: () {}),
                  const Divider(height: 1),
                  _buildListTile('Change Password', Icons.lock, onTap: () {}),
                  const Divider(height: 1),
                  _buildListTile(
                    'Push Notifications',
                    Icons.notifications,
                    trailing: Switch(
                      value: _notificationsEnabled,
                      activeColor: const Color(0xFF1A73E8),
                      onChanged: (val) {
                        setState(() {
                          _notificationsEnabled = val;
                        });
                      },
                    ),
                  ),
                  const Divider(height: 1),
                  _buildListTile('About App', Icons.info_outline, onTap: () {}),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey.shade200),
              ),
              child: _buildListTile(
                'Logout',
                Icons.logout,
                iconColor: Colors.red,
                titleColor: Colors.red,
                trailing: const SizedBox(),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
