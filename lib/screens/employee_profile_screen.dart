import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../theme/app_spacing.dart';
import '../models/employee.dart';
import '../models/dummy_data.dart';
import '../widgets/app_avatar.dart';
import '../widgets/app_card.dart';
import '../widgets/app_button.dart';
import '../widgets/timeline_item.dart';

class EmployeeProfileScreen extends StatefulWidget {
  const EmployeeProfileScreen({super.key});

  @override
  State<EmployeeProfileScreen> createState() => _EmployeeProfileScreenState();
}

class _EmployeeProfileScreenState extends State<EmployeeProfileScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final employee = ModalRoute.of(context)?.settings.arguments as Employee? ?? DummyData.employees.first;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Employee Profile'),
        actions: [
          IconButton(icon: const Icon(Icons.edit_outlined), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            // Profile Header
            Center(
              child: Column(
                children: [
                  AppAvatar(initials: employee.initials, radius: 40),
                  const SizedBox(height: 12),
                  Text(employee.name, style: AppTypography.h2),
                  const SizedBox(height: 4),
                  Text('${employee.id} • ${employee.designation}', style: AppTypography.body.copyWith(color: AppColors.textSecondary)),
                  const SizedBox(height: 2),
                  Text(employee.department, style: AppTypography.caption),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Custom Tab Bar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              height: 44,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: AppSpacing.radiusMd,
              ),
              child: Row(
                children: [
                  _buildTab('Overview', 0),
                  _buildTab('Attendance', 1),
                  _buildTab('Salary', 2),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Employment Details Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Employment Details', style: AppTypography.subtitle.copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 16),
                    _buildDetailRow(Icons.calendar_today, 'Joined', 'June 1, 2023'),
                    const SizedBox(height: 12),
                    _buildDetailRow(Icons.work_outline, 'Type', employee.employmentType),
                    const SizedBox(height: 12),
                    _buildDetailRow(Icons.attach_money, 'Salary', 'PKR ${employee.salary.toStringAsFixed(0)}/month'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // This Month Statistics
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('This Month Statistics', style: AppTypography.subtitle.copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: _buildStatItem('✓', 'Present', '18 days', AppColors.success)),
                        Expanded(child: _buildStatItem('✗', 'Absent', '2 days', AppColors.error)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: _buildStatItem('⏰', 'Hours', '144h', AppColors.accent)),
                        Expanded(child: _buildStatItem('⚠', 'Late', '3 times', AppColors.warning)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Recent Attendance Timeline
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Recent Attendance', style: AppTypography.h3),
                  const SizedBox(height: 16),
                  const TimelineItem(date: 'Jan 27, 2024', checkIn: '09:15 AM', checkOut: '06:30 PM'),
                  const TimelineItem(date: 'Jan 26, 2024', checkIn: '09:00 AM', checkOut: '06:00 PM'),
                  const TimelineItem(date: 'Jan 25, 2024', checkIn: '08:55 AM', checkOut: '05:45 PM'),
                  const TimelineItem(date: 'Jan 24, 2024', checkIn: '09:10 AM', checkOut: '06:15 PM'),
                  const TimelineItem(date: 'Jan 23, 2024', checkIn: '09:30 AM', checkOut: '06:30 PM', isLast: true),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(16),
              child: AppButton(text: 'Edit Profile', onPressed: () {}),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String text, int index) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              text,
              style: AppTypography.body.copyWith(
                color: isSelected ? Colors.white : AppColors.textSecondary,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.textSecondary),
        const SizedBox(width: 12),
        Text('$label:', style: AppTypography.body.copyWith(color: AppColors.textSecondary)),
        const SizedBox(width: 8),
        Text(value, style: AppTypography.body.copyWith(fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildStatItem(String emoji, String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: AppSpacing.radiusMd,
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTypography.caption),
              Text(value, style: AppTypography.body.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }
}
