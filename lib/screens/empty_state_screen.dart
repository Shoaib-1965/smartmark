import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/app_button.dart';

enum EmptyStateType { noData, noEmployees, noDevices, offline }

class EmptyStateScreen extends StatelessWidget {
  final EmptyStateType type;

  const EmptyStateScreen({super.key, this.type = EmptyStateType.noData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(_getAppBarTitle())),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Icon(
                _getIcon(),
                size: 64,
                color: AppColors.textSecondary.withOpacity(0.5),
              ),
              const SizedBox(height: 24),
              Text(
                _getHeading(),
                style: AppTypography.h3.copyWith(color: AppColors.textPrimary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 280),
                child: Text(
                  _getDescription(),
                  style: AppTypography.body.copyWith(color: AppColors.textSecondary),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: 200,
                child: AppButton(
                  text: _getButtonText(),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {},
                child: Text(
                  _getSecondaryButtonText(),
                  style: AppTypography.body.copyWith(color: AppColors.accent),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  String _getAppBarTitle() {
    switch (type) {
      case EmptyStateType.noData:
        return 'Attendance';
      case EmptyStateType.noEmployees:
        return 'Employees';
      case EmptyStateType.noDevices:
        return 'Devices';
      case EmptyStateType.offline:
        return 'Connection';
    }
  }

  IconData _getIcon() {
    switch (type) {
      case EmptyStateType.noData:
        return Icons.inbox_outlined;
      case EmptyStateType.noEmployees:
        return Icons.person_add_outlined;
      case EmptyStateType.noDevices:
        return Icons.router_outlined;
      case EmptyStateType.offline:
        return Icons.signal_wifi_off;
    }
  }

  String _getHeading() {
    switch (type) {
      case EmptyStateType.noData:
        return 'No Attendance Records';
      case EmptyStateType.noEmployees:
        return 'No Employees Yet';
      case EmptyStateType.noDevices:
        return 'No Devices Connected';
      case EmptyStateType.offline:
        return "You're Offline";
    }
  }

  String _getDescription() {
    switch (type) {
      case EmptyStateType.noData:
        return 'Start marking attendance by scanning NFC cards at the device';
      case EmptyStateType.noEmployees:
        return 'Add your first employee to get started';
      case EmptyStateType.noDevices:
        return 'Connect an ESP32 device to begin';
      case EmptyStateType.offline:
        return 'Check your internet connection';
    }
  }

  String _getButtonText() {
    switch (type) {
      case EmptyStateType.noData:
        return 'Set Up Device';
      case EmptyStateType.noEmployees:
        return 'Add Employee';
      case EmptyStateType.noDevices:
        return 'Connect Device';
      case EmptyStateType.offline:
        return 'Retry';
    }
  }

  String _getSecondaryButtonText() {
    switch (type) {
      case EmptyStateType.noData:
        return 'Watch Tutorial';
      case EmptyStateType.noEmployees:
        return 'Learn More';
      case EmptyStateType.noDevices:
        return 'Learn More';
      case EmptyStateType.offline:
        return 'Skip for Now';
    }
  }
}
