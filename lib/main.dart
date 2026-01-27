import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'screens/manager_login_screen.dart';
import 'screens/employee_login_screen.dart';
import 'screens/manager_dashboard_screen.dart';
import 'screens/employee_list_screen.dart';
import 'screens/employee_profile_screen.dart';
import 'screens/nfc_scan_screen.dart';
import 'screens/face_verification_screen.dart';
import 'screens/attendance_log_screen.dart';
import 'screens/salary_calculator_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/empty_state_screen.dart';
import 'screens/error_state_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const SmartMarkApp());
}

class SmartMarkApp extends StatelessWidget {
  const SmartMarkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartMark',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/manager-login': (context) => const ManagerLoginScreen(),
        '/employee-login': (context) => const EmployeeLoginScreen(),
        '/manager-dashboard': (context) => const ManagerDashboardScreen(),
        '/employee-list': (context) => const EmployeeListScreen(),
        '/employee-profile': (context) => const EmployeeProfileScreen(),
        '/nfc-scan': (context) => const NFCScanScreen(),
        '/face-verification': (context) => const FaceVerificationScreen(),
        '/attendance-log': (context) => const AttendanceLogScreen(),
        '/salary-calculator': (context) => const SalaryCalculatorScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/notifications': (context) => const NotificationsScreen(),
        '/empty-state': (context) => const EmptyStateScreen(),
        '/error-state': (context) => const ErrorStateScreen(),
      },
    );
  }
}
