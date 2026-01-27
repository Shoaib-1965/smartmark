import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../theme/app_spacing.dart';

class FaceVerificationScreen extends StatefulWidget {
  const FaceVerificationScreen({super.key});

  @override
  State<FaceVerificationScreen> createState() => _FaceVerificationScreenState();
}

class _FaceVerificationScreenState extends State<FaceVerificationScreen>
    with SingleTickerProviderStateMixin {
  bool _isSuccess = false;
  double _progress = 0.33;
  String _prompt = '😊 Please smile';
  String _status = 'Hold still';
  late AnimationController _scanLineController;
  late Animation<double> _scanLineAnimation;

  @override
  void initState() {
    super.initState();
    _scanLineController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _scanLineAnimation =
        Tween<double>(begin: 0, end: 1).animate(_scanLineController);

    // Simulate verification progress
    Timer(const Duration(seconds: 1), () {
      if (mounted)
        setState(() {
          _progress = 0.66;
          _prompt = '👀 Blink twice';
        });
    });
    Timer(const Duration(seconds: 2), () {
      if (mounted)
        setState(() {
          _progress = 1.0;
          _prompt = '✓ Perfect!';
          _status = 'Perfect!';
        });
    });
    Timer(const Duration(seconds: 3), () {
      if (mounted) setState(() => _isSuccess = true);
    });
    Timer(const Duration(milliseconds: 4500), () {
      if (mounted) Navigator.pushReplacementNamed(context, '/attendance-log');
    });
  }

  @override
  void dispose() {
    _scanLineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Verify Your Face')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Look at the camera and stay still',
              style:
                  AppTypography.body.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            // Camera Preview with Face Detection Box
            Expanded(
              child: Stack(
                children: [
                  // Camera Preview Placeholder
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: AppSpacing.radiusLg,
                    ),
                    child: _isSuccess
                        ? _buildSuccessOverlay()
                        : Stack(
                            alignment: Alignment.center,
                            children: [
                              // Placeholder face image
                              const Icon(Icons.face,
                                  size: 150, color: Colors.white30),
                              // Face Detection Box
                              Container(
                                width: 200,
                                height: 250,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.accent, width: 3),
                                  borderRadius: AppSpacing.radiusMd,
                                ),
                                child: Stack(
                                  children: [
                                    // Corner brackets - Top Left
                                    Positioned(
                                        top: 0,
                                        left: 0,
                                        child: _buildCorner(true, true)),
                                    // Top Right
                                    Positioned(
                                        top: 0,
                                        right: 0,
                                        child: _buildCorner(true, false)),
                                    // Bottom Left
                                    Positioned(
                                        bottom: 0,
                                        left: 0,
                                        child: _buildCorner(false, true)),
                                    // Bottom Right
                                    Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: _buildCorner(false, false)),
                                    // Scanning Line
                                    AnimatedBuilder(
                                      animation: _scanLineAnimation,
                                      builder: (context, child) {
                                        return Positioned(
                                          top: _scanLineAnimation.value * 244,
                                          left: 0,
                                          right: 0,
                                          child: Container(
                                            height: 2,
                                            color: AppColors.accent
                                                .withOpacity(0.6),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Liveness Prompt Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppSpacing.radiusLg,
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 8,
                      color: Colors.black12)
                ],
              ),
              child: Row(
                children: [
                  Text(_prompt.split(' ').first,
                      style: const TextStyle(fontSize: 24)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _prompt.substring(_prompt.indexOf(' ') + 1),
                      style: AppTypography.subtitle,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Progress Indicator
            Column(
              children: [
                ClipRRect(
                  borderRadius: AppSpacing.radiusSm,
                  child: LinearProgressIndicator(
                    value: _progress,
                    backgroundColor: AppColors.border,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(AppColors.accent),
                    minHeight: 6,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Analyzing... ${(_progress * 3).toInt()}/3 checks passed',
                  style: AppTypography.caption,
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Status Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: _status == 'Perfect!'
                    ? AppColors.success.withOpacity(0.15)
                    : AppColors.warning.withOpacity(0.15),
                borderRadius: AppSpacing.radiusMd,
              ),
              child: Text(
                _status,
                style: AppTypography.subtitle.copyWith(
                  color: _status == 'Perfect!'
                      ? AppColors.success
                      : AppColors.warning,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCorner(bool isTop, bool isLeft) {
    return SizedBox(
      width: 30,
      height: 30,
      child: CustomPaint(
        painter: CornerPainter(
          isTop: isTop,
          isLeft: isLeft,
          color: AppColors.accent,
        ),
      ),
    );
  }

  Widget _buildSuccessOverlay() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.success.withOpacity(0.9),
        borderRadius: AppSpacing.radiusLg,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 64),
            const SizedBox(height: 16),
            Text(
              'Face Verified ✓',
              style: AppTypography.h2.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class CornerPainter extends CustomPainter {
  final bool isTop;
  final bool isLeft;
  final Color color;

  CornerPainter(
      {required this.isTop, required this.isLeft, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();

    if (isTop && isLeft) {
      path.moveTo(0, size.height);
      path.lineTo(0, 0);
      path.lineTo(size.width, 0);
    } else if (isTop && !isLeft) {
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
    } else if (!isTop && isLeft) {
      path.moveTo(0, 0);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
    } else {
      path.moveTo(0, size.height);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
