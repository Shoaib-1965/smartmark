import 'employee.dart';
import 'attendance_record.dart';
import 'salary_data.dart';
import 'notification_model.dart';
import 'device.dart';

class DummyData {
  static List<Employee> employees = [
    Employee(
      id: 'EMP001', name: 'Ahmed Khan', department: 'Engineering', designation: 'Software Developer',
      status: 'Present', checkInTime: '09:15 AM', checkOutTime: '06:30 PM',
      email: 'ahmed.khan@smartmark.com', phone: '0300-1234567',
      joinedDate: DateTime(2023, 6, 1), salary: 80000, employmentType: 'Full-time',
    ),
    Employee(
      id: 'EMP002', name: 'Sara Fatima', department: 'Marketing', designation: 'Marketing Manager',
      status: 'Late', checkInTime: '09:28 AM', checkOutTime: null,
      email: 'sara.fatima@smartmark.com', phone: '0301-2345678',
      joinedDate: DateTime(2022, 3, 15), salary: 95000, employmentType: 'Full-time',
    ),
    Employee(
      id: 'EMP003', name: 'Usman Ali', department: 'Sales', designation: 'Sales Executive',
      status: 'Absent', checkInTime: null, checkOutTime: null,
      email: 'usman.ali@smartmark.com', phone: '0302-3456789',
      joinedDate: DateTime(2023, 9, 1), salary: 60000, employmentType: 'Full-time',
    ),
    Employee(
      id: 'EMP004', name: 'Ayesha Malik', department: 'HR', designation: 'HR Specialist',
      status: 'Present', checkInTime: '08:55 AM', checkOutTime: '05:45 PM',
      email: 'ayesha.malik@smartmark.com', phone: '0303-4567890',
      joinedDate: DateTime(2021, 11, 20), salary: 75000, employmentType: 'Full-time',
    ),
    Employee(
      id: 'EMP005', name: 'Hassan Raza', department: 'Engineering', designation: 'Senior Developer',
      status: 'Present', checkInTime: '09:00 AM', checkOutTime: '07:00 PM',
      email: 'hassan.raza@smartmark.com', phone: '0304-5678901',
      joinedDate: DateTime(2020, 5, 10), salary: 120000, employmentType: 'Full-time',
    ),
    Employee(
      id: 'EMP006', name: 'Fatima Zahra', department: 'Finance', designation: 'Accountant',
      status: 'Present', checkInTime: '09:05 AM', checkOutTime: null,
      email: 'fatima.zahra@smartmark.com', phone: '0305-6789012',
      joinedDate: DateTime(2022, 7, 1), salary: 70000, employmentType: 'Full-time',
    ),
    Employee(
      id: 'EMP007', name: 'Ali Hassan', department: 'IT Support', designation: 'IT Technician',
      status: 'Late', checkInTime: '09:35 AM', checkOutTime: null,
      email: 'ali.hassan@smartmark.com', phone: '0306-7890123',
      joinedDate: DateTime(2023, 2, 15), salary: 55000, employmentType: 'Full-time',
    ),
    Employee(
      id: 'EMP008', name: 'Zainab Ahmed', department: 'Design', designation: 'UI/UX Designer',
      status: 'Present', checkInTime: '08:45 AM', checkOutTime: null,
      email: 'zainab.ahmed@smartmark.com', phone: '0307-8901234',
      joinedDate: DateTime(2022, 10, 1), salary: 85000, employmentType: 'Full-time',
    ),
    Employee(
      id: 'EMP009', name: 'Bilal Shah', department: 'Operations', designation: 'Operations Manager',
      status: 'Present', checkInTime: '08:30 AM', checkOutTime: null,
      email: 'bilal.shah@smartmark.com', phone: '0308-9012345',
      joinedDate: DateTime(2019, 8, 20), salary: 110000, employmentType: 'Full-time',
    ),
    Employee(
      id: 'EMP010', name: 'Amna Yousef', department: 'Customer Support', designation: 'Support Lead',
      status: 'Absent', checkInTime: null, checkOutTime: null,
      email: 'amna.yousef@smartmark.com', phone: '0309-0123456',
      joinedDate: DateTime(2021, 4, 5), salary: 65000, employmentType: 'Full-time',
    ),
    Employee(
      id: 'EMP011', name: 'Imran Qureshi', department: 'Engineering', designation: 'DevOps Engineer',
      status: 'Present', checkInTime: '09:10 AM', checkOutTime: null,
      email: 'imran.qureshi@smartmark.com', phone: '0310-1234567',
      joinedDate: DateTime(2022, 1, 10), salary: 100000, employmentType: 'Full-time',
    ),
    Employee(
      id: 'EMP012', name: 'Mariam Nawaz', department: 'Legal', designation: 'Legal Advisor',
      status: 'Present', checkInTime: '09:20 AM', checkOutTime: null,
      email: 'mariam.nawaz@smartmark.com', phone: '0311-2345678',
      joinedDate: DateTime(2020, 12, 1), salary: 130000, employmentType: 'Full-time',
    ),
    Employee(
      id: 'EMP013', name: 'Farhan Siddiqui', department: 'Sales', designation: 'Sales Manager',
      status: 'Late', checkInTime: '09:45 AM', checkOutTime: null,
      email: 'farhan.siddiqui@smartmark.com', phone: '0312-3456789',
      joinedDate: DateTime(2021, 6, 15), salary: 90000, employmentType: 'Full-time',
    ),
    Employee(
      id: 'EMP014', name: 'Rabia Tariq', department: 'Marketing', designation: 'Content Writer',
      status: 'Present', checkInTime: '09:00 AM', checkOutTime: null,
      email: 'rabia.tariq@smartmark.com', phone: '0313-4567890',
      joinedDate: DateTime(2023, 4, 1), salary: 50000, employmentType: 'Full-time',
    ),
    Employee(
      id: 'EMP015', name: 'Kamran Akmal', department: 'Security', designation: 'Security Officer',
      status: 'Present', checkInTime: '07:00 AM', checkOutTime: null,
      email: 'kamran.akmal@smartmark.com', phone: '0314-5678901',
      joinedDate: DateTime(2018, 9, 1), salary: 45000, employmentType: 'Full-time',
    ),
  ];

  static List<AttendanceRecord> attendanceRecords = [
    AttendanceRecord(id: '1', employeeId: 'EMP001', employeeName: 'Ahmed Khan', date: DateTime.now(), checkIn: '09:15 AM', checkOut: '06:30 PM', duration: '9h 15m', nfcVerified: true, faceVerified: true, status: 'Present'),
    AttendanceRecord(id: '2', employeeId: 'EMP002', employeeName: 'Sara Fatima', date: DateTime.now(), checkIn: '09:28 AM', checkOut: '06:45 PM', duration: '9h 17m', nfcVerified: true, faceVerified: true, status: 'Late'),
    AttendanceRecord(id: '3', employeeId: 'EMP003', employeeName: 'Usman Ali', date: DateTime.now(), checkIn: null, checkOut: null, duration: null, nfcVerified: false, faceVerified: false, status: 'Absent'),
    AttendanceRecord(id: '4', employeeId: 'EMP004', employeeName: 'Ayesha Malik', date: DateTime.now(), checkIn: '08:55 AM', checkOut: '05:45 PM', duration: '8h 50m', nfcVerified: true, faceVerified: true, status: 'Present'),
    AttendanceRecord(id: '5', employeeId: 'EMP005', employeeName: 'Hassan Raza', date: DateTime.now(), checkIn: '09:00 AM', checkOut: '07:00 PM', duration: '10h 0m', nfcVerified: true, faceVerified: true, status: 'Present'),
    AttendanceRecord(id: '6', employeeId: 'EMP006', employeeName: 'Fatima Zahra', date: DateTime.now(), checkIn: '09:05 AM', checkOut: '06:15 PM', duration: '9h 10m', nfcVerified: true, faceVerified: true, status: 'Present'),
    AttendanceRecord(id: '7', employeeId: 'EMP007', employeeName: 'Ali Hassan', date: DateTime.now(), checkIn: '09:35 AM', checkOut: '06:30 PM', duration: '8h 55m', nfcVerified: true, faceVerified: true, status: 'Late'),
    AttendanceRecord(id: '8', employeeId: 'EMP008', employeeName: 'Zainab Ahmed', date: DateTime.now(), checkIn: '08:45 AM', checkOut: '05:30 PM', duration: '8h 45m', nfcVerified: true, faceVerified: true, status: 'Present'),
    AttendanceRecord(id: '9', employeeId: 'EMP009', employeeName: 'Bilal Shah', date: DateTime.now(), checkIn: '08:30 AM', checkOut: '06:00 PM', duration: '9h 30m', nfcVerified: true, faceVerified: true, status: 'Present'),
    AttendanceRecord(id: '10', employeeId: 'EMP010', employeeName: 'Amna Yousef', date: DateTime.now(), checkIn: null, checkOut: null, duration: null, nfcVerified: false, faceVerified: false, status: 'Absent'),
    AttendanceRecord(id: '11', employeeId: 'EMP011', employeeName: 'Imran Qureshi', date: DateTime.now(), checkIn: '09:10 AM', checkOut: '07:15 PM', duration: '10h 5m', nfcVerified: true, faceVerified: true, status: 'Present'),
    AttendanceRecord(id: '12', employeeId: 'EMP012', employeeName: 'Mariam Nawaz', date: DateTime.now(), checkIn: '09:20 AM', checkOut: '06:20 PM', duration: '9h 0m', nfcVerified: true, faceVerified: true, status: 'Present'),
    AttendanceRecord(id: '13', employeeId: 'EMP013', employeeName: 'Farhan Siddiqui', date: DateTime.now(), checkIn: '09:45 AM', checkOut: '06:45 PM', duration: '9h 0m', nfcVerified: true, faceVerified: true, status: 'Late'),
    AttendanceRecord(id: '14', employeeId: 'EMP014', employeeName: 'Rabia Tariq', date: DateTime.now(), checkIn: '09:00 AM', checkOut: '06:00 PM', duration: '9h 0m', nfcVerified: true, faceVerified: true, status: 'Present'),
    AttendanceRecord(id: '15', employeeId: 'EMP015', employeeName: 'Kamran Akmal', date: DateTime.now(), checkIn: '07:00 AM', checkOut: '03:00 PM', duration: '8h 0m', nfcVerified: true, faceVerified: true, status: 'Present'),
  ];

  static SalaryData sampleSalary = SalaryData(
    employeeId: 'EMP001', month: 'January', year: 2024, baseSalary: 80000,
    totalDays: 22, presentDays: 20, absentDays: 2, lateDays: 0,
    totalHours: 180, overtimeHours: 10, absentDeduction: 7272, lateDeduction: 0,
    overtimeBonus: 3636, otherBonus: 0, netSalary: 76364,
  );

  static List<NotificationModel> notifications = [
    NotificationModel(id: '1', type: NotificationType.alert, title: 'Failed Verification Attempt', message: 'Employee EMP003 - Face mismatch detected', timestamp: DateTime.now().subtract(const Duration(minutes: 2)), isRead: false),
    NotificationModel(id: '2', type: NotificationType.success, title: 'Attendance Marked', message: 'Ahmed Khan checked in at 09:15 AM', timestamp: DateTime.now().subtract(const Duration(minutes: 15)), isRead: false),
    NotificationModel(id: '3', type: NotificationType.info, title: 'Device Offline', message: 'ESP32_GATE2 lost connection', timestamp: DateTime.now().subtract(const Duration(hours: 1)), isRead: true),
    NotificationModel(id: '4', type: NotificationType.system, title: 'Monthly Report Ready', message: 'January attendance report available', timestamp: DateTime.now().subtract(const Duration(hours: 3)), isRead: true),
    NotificationModel(id: '5', type: NotificationType.success, title: 'New Employee Added', message: 'Rabia Tariq (EMP014) registered successfully', timestamp: DateTime.now().subtract(const Duration(hours: 5)), isRead: true),
    NotificationModel(id: '6', type: NotificationType.alert, title: 'Late Check-in', message: 'Ali Hassan checked in 35 minutes late', timestamp: DateTime.now().subtract(const Duration(hours: 6)), isRead: true),
    NotificationModel(id: '7', type: NotificationType.info, title: 'System Update', message: 'SmartMark v2.1.0 available for download', timestamp: DateTime.now().subtract(const Duration(days: 1)), isRead: true),
    NotificationModel(id: '8', type: NotificationType.success, title: 'Salary Processed', message: 'December payroll completed for 15 employees', timestamp: DateTime.now().subtract(const Duration(days: 2)), isRead: true),
    NotificationModel(id: '9', type: NotificationType.alert, title: 'Multiple Absences', message: '3 employees absent today without prior notice', timestamp: DateTime.now().subtract(const Duration(days: 3)), isRead: true),
    NotificationModel(id: '10', type: NotificationType.system, title: 'Backup Completed', message: 'Weekly data backup successful', timestamp: DateTime.now().subtract(const Duration(days: 4)), isRead: true),
  ];

  static List<Device> devices = [
    Device(id: 'ESP32_MAIN', name: 'Gate 1 - ESP32_MAIN', type: 'ESP32', isOnline: true, lastSync: DateTime.now().subtract(const Duration(minutes: 2)), location: 'Main Entrance'),
    Device(id: 'ESP32_GATE2', name: 'Gate 2 - ESP32_GATE2', type: 'ESP32', isOnline: false, lastSync: DateTime.now().subtract(const Duration(hours: 1)), location: 'Back Entrance'),
    Device(id: 'ESP32_CAFE', name: 'Cafeteria - ESP32_CAFE', type: 'ESP32', isOnline: true, lastSync: DateTime.now().subtract(const Duration(minutes: 5)), location: 'Cafeteria'),
  ];
}
