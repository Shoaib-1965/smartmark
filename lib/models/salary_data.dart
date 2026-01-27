class SalaryData {
  final String employeeId;
  final String month;
  final int year;
  final double baseSalary;
  final int totalDays;
  final int presentDays;
  final int absentDays;
  final int lateDays;
  final double totalHours;
  final double overtimeHours;
  final double absentDeduction;
  final double lateDeduction;
  final double overtimeBonus;
  final double otherBonus;
  final double netSalary;

  SalaryData({
    required this.employeeId,
    required this.month,
    required this.year,
    required this.baseSalary,
    required this.totalDays,
    required this.presentDays,
    required this.absentDays,
    required this.lateDays,
    required this.totalHours,
    required this.overtimeHours,
    required this.absentDeduction,
    required this.lateDeduction,
    required this.overtimeBonus,
    required this.otherBonus,
    required this.netSalary,
  });
}
