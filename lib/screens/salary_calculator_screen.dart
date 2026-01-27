import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../theme/app_spacing.dart';
import '../models/dummy_data.dart';
import '../widgets/app_card.dart';
import '../widgets/app_button.dart';

class SalaryCalculatorScreen extends StatefulWidget {
  const SalaryCalculatorScreen({super.key});

  @override
  State<SalaryCalculatorScreen> createState() => _SalaryCalculatorScreenState();
}

class _SalaryCalculatorScreenState extends State<SalaryCalculatorScreen> {
  String _selectedMonth = 'January 2024';
  final salary = DummyData.sampleSalary;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Salary Calculator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Month Selector
            Row(
              children: [
                Text('Select Month', style: AppTypography.body),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: AppSpacing.radiusMd,
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          size: 18, color: AppColors.textSecondary),
                      const SizedBox(width: 8),
                      DropdownButton<String>(
                        value: _selectedMonth,
                        underline: const SizedBox(),
                        isDense: true,
                        style: AppTypography.body,
                        items: [
                          'January 2024',
                          'December 2023',
                          'November 2023'
                        ]
                            .map((m) =>
                                DropdownMenuItem(value: m, child: Text(m)))
                            .toList(),
                        onChanged: (v) => setState(() => _selectedMonth = v!),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Net Salary Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: AppSpacing.radiusLg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Net Salary',
                    style:
                        AppTypography.caption.copyWith(color: Colors.white70),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'PKR ${salary.netSalary.toStringAsFixed(0)}',
                    style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Based on ${salary.presentDays} working days',
                    style: AppTypography.small.copyWith(color: Colors.white60),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text('Breakdown', style: AppTypography.h3),
            const SizedBox(height: 12),
            // Base Calculations Card
            AppCard(
              child: Column(
                children: [
                  _buildBreakdownRow('💰', 'Base Salary',
                      'PKR ${salary.baseSalary.toStringAsFixed(0)}'),
                  const Divider(height: 24),
                  _buildBreakdownRow('✓', 'Present Days',
                      '${salary.presentDays}/${salary.totalDays}'),
                  const Divider(height: 24),
                  _buildBreakdownRow('⏰', 'Total Hours',
                      '${salary.totalHours.toStringAsFixed(0)}h'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Deductions Card
            AppCard(
              backgroundColor: AppColors.error.withOpacity(0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Deductions',
                      style: AppTypography.subtitle
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  _buildBreakdownRow('❌', 'Absent',
                      '-PKR ${salary.absentDeduction.toStringAsFixed(0)}',
                      valueColor: AppColors.error),
                  const Divider(height: 24),
                  _buildBreakdownRow('⚠️', 'Late',
                      '-PKR ${salary.lateDeduction.toStringAsFixed(0)}',
                      valueColor: AppColors.error),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Additions Card
            AppCard(
              backgroundColor: AppColors.success.withOpacity(0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Additions',
                      style: AppTypography.subtitle
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  _buildBreakdownRow('⬆️', 'Overtime',
                      '+PKR ${salary.overtimeBonus.toStringAsFixed(0)}',
                      valueColor: AppColors.success),
                  const Divider(height: 24),
                  _buildBreakdownRow('🎁', 'Bonus',
                      '+PKR ${salary.otherBonus.toStringAsFixed(0)}',
                      valueColor: AppColors.success),
                ],
              ),
            ),
            const SizedBox(height: 32),
            AppButton(
              text: 'Generate Payslip PDF',
              onPressed: () {},
            ),
            const SizedBox(height: 12),
            AppButton(
              text: 'Send to: 0300-1234567',
              variant: AppButtonVariant.outline,
              icon: Icons.phone_outlined,
              onPressed: () {},
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildBreakdownRow(String emoji, String label, String value,
      {Color? valueColor}) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 20)),
        const SizedBox(width: 12),
        Expanded(child: Text(label, style: AppTypography.body)),
        Text(
          value,
          style: AppTypography.body.copyWith(
            fontWeight: FontWeight.w600,
            color: valueColor ?? AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
