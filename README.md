# SmartMark 🏢

> **Smart Attendance Management System** — NFC + Face Recognition + Mobile App
<img width="951" height="782" alt="logo" src="https://github.com/user-attachments/assets/6222f1a1-ccd7-4789-93da-86770da79d2c" />


---

## What is SmartMark?

SmartMark is a complete **attendance management system** for companies. Employees scan their RFID card at the office door, the system verifies their face via camera, and if both match — the door opens and attendance is auto-logged. Managers and employees can view everything through the mobile app.

---

## How It Works

```
Employee taps RFID card
        ↓
Raspberry Pi reads card → checks Firebase
        ↓
Camera captures face → face recognition matches
        ↓
Both match? → Servo opens door
        ↓
Attendance auto-logged to Firebase
        ↓
Flutter App updates in real-time
```

---

## Features

### 👨‍💼 Manager (Admin)
- View all employee attendance in real-time
- Add / Edit / Remove employees
- Auto-generate employee username & password
- View & download payroll (hourly rate × hours worked)
- Receive notifications (late arrivals, absences)
- Simulate hardware access (demo mode button)

### 👤 Employee
- View personal attendance history
- View monthly salary breakdown
- Update profile photo and info
- Receive salary & attendance notifications

---

## Tech Stack

| Layer | Technology |
|---|---|
| Mobile App | Flutter (Dart) |
| Database | Firebase Firestore |
| Authentication | Firebase Auth |
| File Storage | Firebase Storage |
| Auto Functions | Firebase Cloud Functions |
| Hardware Brain | Raspberry Pi 3B+ |
| Camera | Pi Camera Module V1.3 (5MP) |
| RFID Reader | RC522 (13.56MHz) |
| Employee Cards | MIFARE 1K NFC Cards |
| Door Control | SG90 Servo Motor |
| Pi Language | Python 3 |

---

## Hardware Setup

```
Pi Camera V1.3  ──CSI Port──→ Raspberry Pi 3B+
RC522 RFID      ──SPI Pins──→ Raspberry Pi 3B+
SG90 Servo      ──GPIO Pin──→ Raspberry Pi 3B+
MicroSD 32GB    ──Bottom───→ Raspberry Pi 3B+
Power 5V/2.5A   ──MicroUSB─→ Raspberry Pi 3B+
```

---

## App Pages

```
Auth
├── Splash Screen
├── Login (Manager / Employee)
├── Forgot Password
└── Change Password

Manager
├── Dashboard (stats + activity)
├── Employee List
├── Add Employee
├── Edit Employee
├── Employee Detail
├── Attendance Records
├── Payroll
├── Notifications
└── Settings

Employee
├── Dashboard
├── My Attendance
├── My Salary
├── Profile
├── Notifications
└── Settings
```

---

## App Theme

| Element | Value |
|---|---|
| Background | White `#FFFFFF` |
| Primary | Blue `#1A73E8` |
| Text | Black `#0D0D0D` |
| Cards | Light Grey `#F5F7FA` |
| Font | Inter |

---

## Project Structure

```
smartmark/
├── assets/
│   └── logo.png
├── lib/
│   ├── main.dart
│   ├── screens/
│   │   ├── auth/
│   │   │   ├── login_page.dart
│   │   │   ├── forgot_password_page.dart
│   │   │   └── change_password_page.dart
│   │   ├── manager/
│   │   │   ├── dashboard.dart
│   │   │   ├── employee_list.dart
│   │   │   ├── add_employee.dart
│   │   │   ├── edit_employee.dart
│   │   │   ├── employee_detail.dart
│   │   │   ├── attendance.dart
│   │   │   ├── payroll.dart
│   │   │   ├── notifications.dart
│   │   │   └── settings.dart
│   │   └── employee/
│   │       ├── dashboard.dart
│   │       ├── attendance.dart
│   │       ├── salary.dart
│   │       ├── profile.dart
│   │       ├── notifications.dart
│   │       └── settings.dart
│   ├── models/
│   │   ├── employee_model.dart
│   │   ├── attendance_model.dart
│   │   └── payroll_model.dart
│   ├── services/
│   │   ├── auth_service.dart
│   │   ├── firestore_service.dart
│   │   └── storage_service.dart
│   └── widgets/
│       └── common_widgets.dart
└── pubspec.yaml
```

---

## Firebase Collections

```
users/
├── uid
│   ├── name, email, role (manager/employee)
│   ├── cnic, department, hourlyRate
│   ├── rfidUID, photoURL
│   └── joinDate

access_logs/
├── docId
│   ├── employeeId, employeeName
│   ├── timestamp, status (granted/denied)
│   └── checkIn, checkOut

attendance/
├── docId
│   ├── employeeId, date
│   ├── checkIn, checkOut, totalHours
│   └── status (present/absent/late)

payroll/
├── docId
│   ├── employeeId, month, year
│   ├── daysPresent, totalHours
│   ├── hourlyRate, totalSalary
│   └── status (paid/unpaid)

notifications/
├── docId
│   ├── userId, title, message
│   ├── type, isRead
│   └── timestamp
```

---

## Demo Mode (Hardware Simulation)

Since hardware setup takes time, SmartMark includes a **Simulate Access** button on the Manager Dashboard.

- Select any employee from list
- Press **Grant Access**
- App writes to `access_logs` collection
- Attendance auto-logs — exactly as real hardware would do
- Remove this button when hardware is ready

---

## Getting Started

### 1. Clone Repository
```bash
git clone https://github.com/Shoaib-1965/smartmark.git
cd smartmark
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Add Logo
```
Place your logo at: assets/logo.png
```

### 4. Firebase Setup
- Firebase is already connected
- Make sure `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) are in place

### 5. Run App
```bash
flutter run
```

---

## Python Libraries (Raspberry Pi)

```bash
pip install face_recognition
pip install firebase-admin
pip install opencv-python
pip install RPi.GPIO
pip install mfrc522
```

---

## Developer

**Shoaib**
University Project — SmartMark
GitHub: [github.com/Shoaib-1965/smartmark](https://github.com/Shoaib-1965/smartmark)

---

*SmartMark — Making Attendance Smart* 🚀
