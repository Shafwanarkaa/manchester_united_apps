# 🔴 Manchester United Fan App 🔴

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![MU FC](https://img.shields.io/badge/Manchester_United-DA291C?style=for-the-badge&logo=manchester-united&logoColor=white)](https://www.manutd.com)

Welcome to the ultimate **Manchester United Fan Experience**! This Flutter application is designed for the most loyal Red Devils, providing a premium, modern, and high-performance interface to stay updated with your favorite club.

---

## ✨ Key Features

### 🏟️ Match Hub

- **Live-Sync Standings:** Accurate Premier League table with MU highlighted in red.
- **Dynamic Fixtures:** Stay updated with the latest results (like the 1-1 draw at Leeds) and upcoming match schedules.
- **MU Branding:** Every screen is meticulously styled with official Red, Black, and Gold colors.

### 🛍️ Official Shop

- **Featured Carousel:** Smooth auto-scrolling carousel showcasing the latest kits and merchandise.
- **Premium Product Details:** A sophisticated `SliverAppBar` experience that transitions from transparent to solid MU Red as you scroll.
- **Shopping Cart:** Seamlessly add items and manage your merchandise inventory.

### 👥 Squad Explorer

- **Detailed Player Cards:** Explore the squad with high-quality images, jersey numbers, and position classifications.

### ⚡ Performance & Polish

- **Animated Splash Screen:** A beautiful, branded entrance to the app.
- **Web & Mobile Support:** Fully responsive design that looks stunning on mobile devices and web browsers.
- **SEO Optimized (Web):** Custom MU favicon and metadata for a professional web presence.

---

## 🚀 Getting Started

Follow these steps to get the project running on your local machine.

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed.
- An IDE (VS Code, Android Studio, or IntelliJ).

### Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/your-username/manchester-united-fan-app.git
   cd manchester-united-fan-app
   ```

2. **API Configuration:**

   - Create a `.env` file in the root directory:
     ```bash
     cp .env.example .env
     ```
   - Open `.env` and replace the placeholders with your own keys from:
     - [Football-Data.org](https://www.football-data.org/)
     - [RapidAPI (API-Football)](https://rapidapi.com/api-sports/api/api-football)
     - [NewsAPI](https://newsapi.org/)

3. **Install dependencies:**

   ```bash
   flutter pub get
   ```

4. **Run the application:**

   ```bash
   # Run on connected mobile device or emulator
   flutter run

   # Run on Chrome/Edge (Web)
   flutter run -d edge
   ```

---

## 🎨 Design Philosophy

The app follows a **"Simple, Elegant, Modern"** aesthetic. It utilizes:

- **Primary Color:** `#DA291C` (MU Red)
- **Secondary Color:** `#000000` (Classic Black)
- **Accent Color:** `#FDB913` (Glory Gold)
- **Typography:** Bold, clean headers and accessible body text.

---

## 🛠️ Built With

- **Flutter** - The UI framework.
- **Provider** - For efficient state management (Cart Service).
- **Intl** - For currency and date formatting.
- **http** - For real-time API integrations.

---

## 📜 Credits

Developed with Passion for the Red Devils by **Shafwan**.

---

**Glory Glory Manchester United! 🔴⚫✨**
