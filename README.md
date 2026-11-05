<h1 align="center">AMS: Absence Management System (mobile app)</h1>

<p align="center">
  The students' app of ESI-SBA's attendance platform: scan the teacher's QR code to be marked
  present, follow absences per module, justify them, and get notified in real time.
</p>

<p align="center">
  <img alt="Flutter" src="https://img.shields.io/badge/Flutter-Dart_3.10-02569B?logo=flutter&logoColor=white">
  <img alt="Bloc / Cubit" src="https://img.shields.io/badge/state-Cubit_(flutter__bloc)-1C3A55">
  <img alt="Dio" src="https://img.shields.io/badge/HTTP-Dio-0175C2">
  <img alt="English and Arabic" src="https://img.shields.io/badge/i18n-English_%7C_Arabic-5C6BC0">
</p>

## Overview

AMS replaces paper attendance sheets at the Higher School of Computer Science of Sidi Bel Abbès (ESI-SBA). This repository is the mobile app used by **students**; administrators and teachers use the web app. Year-end project (PFA), 2025–2026.

| Repository                                                                               | Role                                      |
| ---------------------------------------------------------------------------------------- | ----------------------------------------- |
| **Absence-Management-mobile** (this one)                                                 | Mobile app for students (Flutter)         |
| [Absence-Management-backend](https://github.com/ay-boutera/Absence-Management-backend)   | REST and WebSocket API (FastAPI)          |
| [Absence-Management-frontend](https://github.com/ay-boutera/Absence-Management-frontend) | Web app for admins and teachers (Next.js) |
| [Absence-Management](https://github.com/ay-boutera/Absence-Management)                   | All three as Git submodules               |

## Features

- **Check in with a QR code.** The camera scans the code shown by the teacher and sends it to the API (`POST /api/v1/attendance/mark-present`); the code changes every 30 seconds, so it cannot be shared.
- **Today's classes.** The student's timetable, day by day.
- **My absences.** Absences per module and per semester, the attendance rate, and the details of each absence, including why a justification was rejected.
- **Justify an absence.** Choose the session and a reason, add a comment, and attach a photo or a file.
- **Make-up sessions.** The sessions available to catch up on a missed class.
- **Live notifications.** A WebSocket connection to the API delivers justification decisions and absence warnings as they happen, with a notifications screen.
- **Profile.** Personal information, password change, English or Arabic (right-to-left), light or dark theme.

## Tech stack

| Area                 | Tools                                                    |
| -------------------- | -------------------------------------------------------- |
| Framework            | Flutter, Dart 3.10                                       |
| State                | Cubit (`flutter_bloc`), `equatable`                      |
| Dependency injection | `get_it`, `injectable`                                   |
| Network              | Dio and `http`, `web_socket_channel`                     |
| Storage              | `flutter_secure_storage` (tokens), `shared_preferences`  |
| Device               | `mobile_scanner` (QR codes), `image_picker`, `file_picker` |
| Languages            | Flutter localizations (`intl`, ARB files): English, Arabic |

## Getting started

**Requirements:** the Flutter SDK (Dart 3.10 or later), and an Android or iOS device or emulator.

```bash
git clone https://github.com/ay-boutera/Absence-Management-mobile.git
cd Absence-Management-mobile
flutter pub get
flutter run
```

The app talks to the deployed backend by default. To use a local one, pass its address at build time:

```bash
# Android emulator: 10.0.2.2 is the host machine
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8000
```

## Project structure

```
lib/
├── main.dart, app.dart     # entry point, theme, routes, localization
├── config/                 # constants, router, theme (light and dark)
├── core/                   # entities, network (Dio, endpoints), storage, errors, shared widgets
├── features/               # one folder per feature
│   ├── auth/               #   splash and login
│   ├── home/               #   timetable
│   ├── qr_scanner/         #   camera scanner, success and error screens
│   ├── absences/           #   absences per module and semester
│   ├── absence_details/    #   one absence and its justification
│   ├── justify_absence/    #   justification form and document upload
│   ├── make_up_sessions/   #   available make-up sessions
│   ├── notifications/      #   WebSocket and notifications screen
│   └── profile/            #   profile, language, theme, password
├── injection/              # dependency injection setup
└── l10n/                   # English and Arabic translations
```

## Team

- [i-brahmi](https://github.com/i-brahmi): mobile app
- [Boutera Ahmed Yassine](https://github.com/ay-boutera): backend
- [trarifouad](https://github.com/trarifouad): web app
