# 🌤️ Weather App

A feature-rich, high-performance Flutter weather application built using **Clean Architecture**, **BLoC Pattern**, **Glassmorphic UI Design System**, and **Dynamic Atmospheric Gradients**.

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![BLoC](https://img.shields.io/badge/State_Management-BLoC-546E7A?style=for-the-badge&logo=flutter&logoColor=white)
![Architecture](https://img.shields.io/badge/Architecture-Clean_Architecture-4CAF50?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-blue.style=for-the-badge)

---

## 📱 Screenshots

<p align="center">
 <img src="assets/screenshots/splash.jpg" width="45%" alt="" />
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="assets/screenshots/home_screen1.jpg" width="45%" alt="Home Screen Weather View" />
  &nbsp;&nbsp;&nbsp;&nbsp;
    <img src="assets/screenshots/home_screen2.jpg" width="45%" alt="Home Screen Weather View" />
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="assets/screenshots/search_screen.jpg" width="45%" alt="City Search & Detailed Weather" />
</p>

---

## ✨ Features

- 🌈 **Dynamic Atmospheric Backgrounds**: Background gradients dynamically shift based on real-time weather conditions (Clear Sky, Clouds, Rain, Thunderstorm, Snow) and light/dark theme preference.
- 💎 **Glassmorphic UI System**: Translucent frosted glass containers (`BackdropFilter`) with subtle glowing borders and soft drop shadows.
- 🎨 **Centralized Color Management**: All colors, theme palettes, metric accents, and weather gradients are managed centrally in `AppColors`.
- ⚡ **Hero Weather Card & Lottie Animations**: Giant temperature typography (`84px`), weather condition pills, and animated Lottie visuals.
- 📊 **2x2 Weather Metrics Grid**: Real-time data for **Humidity**, **Feels Like**, **Wind Speed**, and **Condition** with custom icon badges.
- ⏰ **Hourly Forecast & 5-Day Forecast**:
  - Horizontally scrollable frosted glass pills with an active glowing border for the current hour.
  - 5-Day forecast cards displaying day names, weather condition pills, and temperature badges.
- 🔍 **City Search with Quick Recommendation Chips**: Frosted search field with quick suggestion chips (*London, New York, Tokyo, Paris, Sydney, Dubai*).
- ⚙️ **Light & Dark Theme Switch**: Seamless theme toggling via `ThemeCubit`.
- 🚀 **Smart Tab State Preservation**: Tab navigation powered by `IndexedStack` to preserve screen state with zero re-loading flicker.
- 💾 **Offline Cache & Resilience**: Weather data cached locally with SQLite (`sqflite`) for uninterrupted offline usage.

---

## 🛠️ Tech Stack & Packages

| Package | Purpose |
| :--- | :--- |
| [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) | Predictable State Management |
| [`get_it`](https://pub.dev/packages/get_it) | Service Locator / Dependency Injection |
| [`dio`](https://pub.dev/packages/dio) | HTTP Client for REST API Requests |
| [`geolocator`](https://pub.dev/packages/geolocator) | Device GPS Location Provider |
| [`sqflite`](https://pub.dev/packages/sqflite) | Local SQLite Database for Offline Caching |
| [`lottie`](https://pub.dev/packages/lottie) | Vector Weather Animations |
| [`equatable`](https://pub.dev/packages/equatable) | Value Equality Comparison for BLoC States |
| [`intl`](https://pub.dev/packages/intl) | Date and Time Formatting |

