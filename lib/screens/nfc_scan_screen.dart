import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../theme/app_spacing.dart';
import '../widgets/dashed_border_painter.dart';
import '../widgets/app_button.dart';

class NFCScanScreen extends StatefulWidget {
  const NFCScanScreen({super.key});

  @override
  State<NFCScanScreen> createState() => _NFCScanScreenState();
}

class _NFCScanScreenState extends State<NFCScanScreen>
    with SingleTickerProviderStateMixin {
  bool _isSuccess = false;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Simulate NFC scan success after 2 seconds
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isSuccess = true);
        Timer(const Duration(milliseconds: 1500), () {
          if (mounted) {
            Navigator.pushReplacementNamed(context, '/face-verification');
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Scan Card')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              'Hold NFC card near device',
              style:
                  AppTypography.body.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            // Main Scan Card
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _isSuccess ? _buildSuccessState() : _buildScanState(),
            ),
            const SizedBox(height: 32),
            // Last Scanned
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: AppSpacing.radiusMd,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.check_circle,
                      color: AppColors.success, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Last: Ahmed Khan • 09:15 AM',
                    style: AppTypography.body.copyWith(fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            // Status Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStatusDot(AppColors.success),
                const SizedBox(width: 8),
                _buildStatusDot(AppColors.success),
                const SizedBox(width: 8),
                _buildStatusDot(
                    _isSuccess ? AppColors.success : AppColors.warning),
              ],
            ),
            const Spacer(),
            AppButton(
              text: 'Manual Override',
              variant: AppButtonVariant.outline,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScanState() {
    return DashedBorderContainer(
      color: AppColors.accent,
      strokeWidth: 3,
      dashWidth: 10,
      gap: 6,
      radius: 16,
      child: Container(
        width: 280,
        height: 320,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _pulseAnimation,
              child: const Icon(Icons.nfc, size: 64, color: AppColors.accent),
            ),
            const SizedBox(height: 16),
            Text('Waiting for card...', style: AppTypography.subtitle),
            const SizedBox(height: 24),
            AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Container(
                  width: 60 * _pulseAnimation.value,
                  height: 60 * _pulseAnimation.value,
                  decoration: BoxDecoration(
                    color: AppColors.accent.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.accent.withOpacity(0.4),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessState() {
    return Container(
      width: 280,
      height: 320,
      decoration: BoxDecoration(
        color: AppColors.success.withOpacity(0.1),
        borderRadius: AppSpacing.radiusXl,
        border: Border.all(color: AppColors.success, width: 3),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              color: AppColors.success,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, color: Colors.white, size: 48),
          ),
          const SizedBox(height: 16),
          Text('Success!',
              style: AppTypography.h2.copyWith(color: AppColors.success)),
          const SizedBox(height: 8),
          Text('Ahmed Khan', style: AppTypography.subtitle),
        ],
      ),
    );
  }

  Widget _buildStatusDot(Color color) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
