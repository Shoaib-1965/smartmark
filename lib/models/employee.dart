class Employee {
  final String id;
  final String name;
  final String department;
  final String designation;
  final String status;
  final String? checkInTime;
  final String? checkOutTime;
  final String email;
  final String phone;
  final DateTime joinedDate;
  final double salary;
  final String employmentType;

  Employee({
    required this.id,
    required this.name,
    required this.department,
    required this.designation,
    required this.status,
    this.checkInTime,
    this.checkOutTime,
    required this.email,
    required this.phone,
    required this.joinedDate,
    required this.salary,
    required this.employmentType,
  });

  String get initials {
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.substring(0, 2).toUpperCase();
  }
}
