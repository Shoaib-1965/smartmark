# 🎓 SmartMark Attendance & Salary System

> **Final Year Project | Computer Science Department**  
> *Building the future of automated attendance management*

---

## 👥 Team Members

| Name | Role | GitHub |
|------|------|--------|
| **Bazeed Khan** | Team Lead & Full-Stack Developer | [@bazeedkhan](#) |
| **Faizan Haider** | Hardware Engineer & Backend Developer | [@faizanhaider](#) |
| **Shoaib** | UI/UX Designer & Frontend Developer | [@shoaib](#) |

**Supervisor**: [Supervisor Name]  
**Session**: 2024-2025  
**University**: [Your University Name]

---

## 📌 Project Overview

SmartMark is an innovative attendance and salary management system that combines **NFC technology** with **AI-powered face recognition** to eliminate buddy punching and automate payroll calculations. Our solution addresses the critical challenges faced by organizations in tracking employee attendance accurately and efficiently.

### 🎯 Problem Statement

Traditional attendance systems suffer from:
- ❌ Buddy punching (proxy attendance)
- ❌ Manual data entry errors
- ❌ Time-consuming salary calculations
- ❌ Lack of real-time reporting
- ❌ Security vulnerabilities

### 💡 Our Solution

SmartMark implements **dual-factor verification** combining:
1. **NFC Card Scanning** - Fast, contactless identification
2. **Face Recognition** - AI-powered biometric verification
3. **Automated Salary Processing** - Based on working hours and attendance
4. **Real-time Cloud Sync** - Instant updates across all devices

---

## ✨ Key Features (Under Development)

### 📱 Mobile Application (Flutter)
- [x] Modern, intuitive user interface
- [x] Manager & Employee login portals
- [x] Real-time attendance dashboard
- [x] Employee management system
- [ ] **In Progress**: Live face verification
- [ ] **In Progress**: NFC scanning integration
- [ ] **Planned**: Automated salary calculator
- [ ] **Planned**: Attendance reports & analytics
- [ ] **Planned**: Push notifications

### 🔧 Hardware Components
- [ ] **In Development**: ESP32 main controller
- [ ] **In Development**: PN532 NFC reader module
- [ ] **In Development**: ESP32-CAM for face capture
- [ ] **Testing**: Device pairing & communication
- [ ] **Planned**: 3D-printed enclosure design

### ☁️ Backend & Cloud Services
- [ ] **In Progress**: Firebase Firestore database
- [ ] **In Progress**: Firebase Authentication
- [ ] **Planned**: Firebase Storage for employee photos
- [ ] **Planned**: Face recognition ML model training
- [ ] **Planned**: RESTful API for ESP32 communication

---

## 🏗️ System Architecture
```
┌─────────────────────────────────────────┐
│      Flutter Mobile App (Frontend)      │
│  • Manager Dashboard                    │
│  • Employee Portal                      │
│  • Attendance Reports                   │
└─────────────┬───────────────────────────┘
              │ HTTPS/WebSocket
              ▼
┌─────────────────────────────────────────┐
│    Firebase Backend (Cloud Services)    │
│  • Firestore Database                   │
│  • Authentication                       │
│  • Cloud Storage                        │
│  • ML Face Recognition API              │
└─────────────┬───────────────────────────┘
              │ HTTPS
              ▼
┌─────────────────────────────────────────┐
│   ESP32 Hardware Device (Entry Point)   │
│  • PN532 NFC Reader                     │
│  • ESP32-CAM Module                     │
│  • LED Indicators                       │
│  • WiFi Communication                   │
└─────────────────────────────────────────┘
```

---

## 🛠️ Technology Stack

### Frontend
- **Framework**: Flutter 3.10+
- **Language**: Dart 3.0+
- **UI Components**: Material Design 3
- **State Management**: Provider (planned)
- **Packages**: 
  - `google_fonts` - Typography
  - `firebase_core` - Firebase integration
  - `cloud_firestore` - Database
  - `google_mlkit_face_detection` - Face recognition

### Hardware
- **Microcontroller**: ESP32 WROOM-32
- **NFC Reader**: PN532 (13.56 MHz)
- **Camera**: ESP32-CAM with OV2640 sensor
- **NFC Cards**: NTAG215 cards
- **Programming**: Arduino IDE, C++

### Backend
- **Database**: Cloud Firestore (NoSQL)
- **Authentication**: Firebase Auth
- **Storage**: Firebase Storage
- **Hosting**: Firebase Hosting (planned)

---

## 📊 Current Progress

### ✅ Completed
- [x] Project proposal and research
- [x] UI/UX design (14 screens)
- [x] Flutter app structure and navigation
- [x] Design system and reusable components
- [x] Hardware component procurement
- [x] Firebase project setup

### 🚧 In Progress
- [ ] ESP32 NFC reader integration (70% complete)
- [ ] Face detection implementation (50% complete)
- [ ] Firebase Firestore integration (60% complete)
- [ ] Employee registration module (40% complete)

### 📅 Upcoming Tasks
- [ ] ESP32-CAM face capture testing
- [ ] Face recognition model training
- [ ] Salary calculation algorithm
- [ ] Report generation system
- [ ] Hardware enclosure design
- [ ] System testing and debugging
- [ ] Documentation and user manual

---

## 🎨 App Screenshots

### Current UI Designs
> *Screenshots will be added as development progresses*

| Splash Screen | Manager Login | Dashboard |
|--------------|---------------|-----------|
| Coming Soon | Coming Soon | Coming Soon |

---

## 🔌 Hardware Setup (In Development)

### Components Required
- **ESP32 Development Board** - Main microcontroller
- **PN532 NFC Module** - Card reading
- **ESP32-CAM Module** - Face capture
- **NTAG215 NFC Cards** - Employee cards
- **5V 2A Power Supply** - Device power
- **LEDs & Buzzer** - Status indicators
- **Connecting Wires** - Circuit connections

### Wiring Diagram
> *Detailed wiring diagram coming soon*

---

## 🚀 Getting Started

### Prerequisites
```bash
Flutter SDK 3.10 or higher
Dart 3.0 or higher
Android Studio / VS Code
Git
```

### Installation (For Development Team)
```bash
# Clone the repository
git clone https://github.com/bazeedkhan/smartmark-flutter.git

# Navigate to project directory
cd smartmark-flutter

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### For Hardware Testing
```bash
# Install Arduino IDE
# Add ESP32 board support
# Install required libraries:
# - Adafruit PN532
# - ESP32 Camera
```

---

## 📝 Project Timeline

| Phase | Duration | Status |
|-------|----------|--------|
| Research & Planning | Week 1-2 | ✅ Complete |
| UI/UX Design | Week 3-4 | ✅ Complete |
| Flutter Development | Week 5-8 | 🚧 In Progress |
| Hardware Integration | Week 6-9 | 🚧 In Progress |
| Backend Setup | Week 7-10 | 🚧 In Progress |
| Testing & Debugging | Week 11-12 | ⏳ Pending |
| Documentation | Week 13-14 | ⏳ Pending |
| Final Presentation | Week 15 | ⏳ Pending |

---

## 📖 Documentation

- [ ] **System Requirements Document** - In Progress
- [ ] **Technical Specification** - In Progress
- [ ] **User Manual** - Planned
- [ ] **Hardware Setup Guide** - Planned
- [ ] **API Documentation** - Planned

---

## 🎯 Project Goals

### Primary Objectives
- ✅ Develop a fully functional attendance system
- ✅ Implement secure dual-factor authentication
- ✅ Create user-friendly mobile interface
- ✅ Automate salary calculations
- ✅ Provide real-time analytics

### Secondary Objectives
- 📊 Generate exportable reports (CSV, PDF)
- 🔔 Push notifications for attendance events
- 📱 Support for multiple devices
- 🌐 Offline mode with sync capability
- 🔒 Role-based access control

---

## 🤝 Contributing

This is a university project currently under active development by our team. External contributions are not accepted at this time, but we welcome suggestions and feedback!

---

## 📧 Contact

**Project Team Email**: smartmark.fyp@example.com

**Individual Contacts**:
- Bazeed Khan (Team Lead): bazeed@example.com
- Faizan Haider: faizan@example.com
- Shoaib: shoaib@example.com

---

## 📄 License

This project is developed as part of our university final year project. All rights reserved by the project team.

---

## 🙏 Acknowledgments

We would like to thank:
- Our project supervisor **[Supervisor Name]** for continuous guidance
- **[University Name]** for providing resources and support
- The Flutter and Firebase communities for excellent documentation
- All open-source contributors whose packages we use

---

## 📌 Project Status
```
🟢 Active Development | 🎓 Final Year Project | ⏰ Expected Completion: [Month Year]
```

**Last Updated**: January 27, 2026

---

<div align="center">

**Built with ❤️ by Team SmartMark**

[![Flutter](https://img.shields.io/badge/Flutter-3.10+-02569B?logo=flutter)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Cloud-FFCA28?logo=firebase)](https://firebase.google.com)
[![ESP32](https://img.shields.io/badge/ESP32-IoT-000000?logo=espressif)](https://www.espressif.com)
[![MIT License](https://img.shields.io/badge/License-Academic-blue.svg)](LICENSE)

</div>
