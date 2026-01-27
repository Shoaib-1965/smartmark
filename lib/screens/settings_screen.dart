import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../theme/app_spacing.dart';
import '../models/dummy_data.dart';
import '../widgets/app_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Connected Devices Section
          Text('Connected Devices', style: AppTypography.h3),
          const SizedBox(height: 12),
          ...DummyData.devices.map((device) => _buildDeviceCard(device)),
          const SizedBox(height: 8),
          // Add New Device Button
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border:
                  Border.all(color: AppColors.border, style: BorderStyle.solid),
              borderRadius: AppSpacing.radiusMd,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.add, color: AppColors.accent),
                const SizedBox(width: 8),
                Text('Add New Device',
                    style: AppTypography.body.copyWith(
                        color: AppColors.accent, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // System Settings Section
          Text('System Settings', style: AppTypography.h3),
          const SizedBox(height: 12),
          AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _buildSettingTile(
                    'Office Hours', '9:00 AM - 6:00 PM', Icons.access_time),
                const Divider(height: 1),
                _buildSettingTile(
                    'Late Threshold', '15 minutes', Icons.timer_outlined),
                const Divider(height: 1),
                _buildSettingTile('Face Match', '85% confidence', Icons.tune),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Network Status Section
          Text('Network Status', style: AppTypography.h3),
          const SizedBox(height: 12),
          AppCard(
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.wifi, color: AppColors.success),
                    const SizedBox(width: 12),
                    Expanded(
                        child: Text('Connected to Office-WiFi',
                            style: AppTypography.body)),
                    const Icon(Icons.check_circle,
                        color: AppColors.success, size: 20),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.cloud_done, color: AppColors.success),
                    const SizedBox(width: 12),
                    Expanded(
                        child:
                            Text('All data synced', style: AppTypography.body)),
                    const Icon(Icons.check_circle,
                        color: AppColors.success, size: 20),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Data & Privacy Section
          Text('Data & Privacy', style: AppTypography.h3),
          const SizedBox(height: 12),
          AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _buildActionTile('Clear cache', Icons.delete_outline, () {}),
                const Divider(height: 1),
                _buildActionTile(
                    'Export all data', Icons.download_outlined, () {}),
                const Divider(height: 1),
                _buildActionTile(
                    'Privacy policy', Icons.arrow_forward_ios, () {},
                    iconSize: 16),
              ],
            ),
          ),
          const SizedBox(height: 40),
          // Sign Out Button
          Center(
            child: TextButton(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, '/manager-login'),
              child: Text(
                'Sign Out',
                style: AppTypography.subtitle.copyWith(color: AppColors.error),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildDeviceCard(device) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppSpacing.radiusMd,
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 1),
              blurRadius: 3,
              color: Colors.black.withOpacity(0.08))
        ],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              const Icon(Icons.router,
                  size: 32, color: AppColors.textSecondary),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color:
                        device.isOnline ? AppColors.success : AppColors.error,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(device.name, style: AppTypography.subtitle),
                const SizedBox(height: 2),
                Text(
                  '${device.isOnline ? "Online" : "Offline"} • Last sync: ${device.lastSyncText}',
                  style: AppTypography.caption,
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Configure',
                style: TextStyle(color: AppColors.accent)),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile(String title, String value, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textSecondary),
      title: Text(title, style: AppTypography.body),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value,
              style:
                  AppTypography.body.copyWith(color: AppColors.textSecondary)),
          const SizedBox(width: 8),
          const Icon(Icons.edit_outlined,
              size: 18, color: AppColors.textSecondary),
        ],
      ),
    );
  }

  Widget _buildActionTile(String title, IconData icon, VoidCallback onTap,
      {double iconSize = 20}) {
    return ListTile(
      title: Text(title, style: AppTypography.body),
      trailing: Icon(icon, size: iconSize, color: AppColors.textSecondary),
      onTap: onTap,
    );
  }
}
