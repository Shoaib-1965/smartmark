import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../theme/app_spacing.dart';
import '../widgets/app_button.dart';

enum ErrorStateType {
  cameraPermission,
  nfcUnavailable,
  networkOffline,
  genericError
}

class ErrorStateScreen extends StatelessWidget {
  final ErrorStateType type;

  const ErrorStateScreen({super.key, this.type = ErrorStateType.genericError});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    switch (type) {
      case ErrorStateType.cameraPermission:
        return _buildCameraPermission(context);
      case ErrorStateType.nfcUnavailable:
        return _buildNFCUnavailable(context);
      case ErrorStateType.networkOffline:
        return _buildNetworkOffline(context);
      case ErrorStateType.genericError:
        return _buildGenericError(context);
    }
  }

  Widget _buildCameraPermission(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: AppSpacing.radiusXl,
            boxShadow: const [
              BoxShadow(
                  offset: Offset(0, 8), blurRadius: 16, color: Colors.black26)
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.camera_alt_outlined,
                  size: 64, color: AppColors.error),
              const SizedBox(height: 16),
              Text('Camera Access Needed',
                  style: AppTypography.h3, textAlign: TextAlign.center),
              const SizedBox(height: 12),
              Text(
                'SmartMark needs camera access for face verification',
                style:
                    AppTypography.body.copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Not Now',
                        style: TextStyle(color: AppColors.textSecondary)),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    child: const Text('Enable Camera'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNFCUnavailable(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFfef3c7),
              borderRadius: AppSpacing.radiusMd,
            ),
            child: Row(
              children: [
                const Icon(Icons.warning_amber,
                    color: Color(0xFFb45309), size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('NFC Not Supported',
                          style: AppTypography.subtitle
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 4),
                      Text("This device doesn't support NFC scanning",
                          style: AppTypography.caption),
                      const SizedBox(height: 2),
                      Text('Use face verification only',
                          style: AppTypography.caption
                              .copyWith(color: AppColors.accent)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          AppButton(
            text: 'Continue with Face Only',
            onPressed: () =>
                Navigator.pushReplacementNamed(context, '/face-verification'),
            width: 250,
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Go Back',
                style: TextStyle(color: AppColors.textSecondary)),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildNetworkOffline(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off,
                size: 64, color: AppColors.textSecondary),
            const SizedBox(height: 24),
            Text("You're Offline", style: AppTypography.h2),
            const SizedBox(height: 12),
            Text(
              'Some features may not work',
              style:
                  AppTypography.body.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: 200,
              child: AppButton(
                  text: 'Retry', onPressed: () => Navigator.pop(context)),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Continue in offline mode',
                  style: TextStyle(color: AppColors.textSecondary)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenericError(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: AppSpacing.radiusLg,
            boxShadow: const [
              BoxShadow(
                  offset: Offset(0, 4), blurRadius: 8, color: Colors.black12)
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 64, color: AppColors.error),
              const SizedBox(height: 16),
              Text('Something went wrong', style: AppTypography.h3),
              const SizedBox(height: 12),
              Text(
                'Please try again or contact support if the problem persists.',
                style:
                    AppTypography.body.copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: 200,
                child: AppButton(
                    text: 'Retry', onPressed: () => Navigator.pop(context)),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {},
                child: const Text('Get Help',
                    style: TextStyle(color: AppColors.accent)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Helper function to show camera permission dialog
void showCameraPermissionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) =>
        const ErrorStateScreen(type: ErrorStateType.cameraPermission),
  );
}
