# TypePro - Modern Typing Speed Trainer

A beautiful, offline-first typing speed and accuracy trainer built with Flutter. Features a modern glassmorphic UI with smooth animations and comprehensive typing challenges.

## ✨ Features

### 🎯 Core Functionality
- **100% Offline** - No internet required, works anywhere
- **Sentence Practice** - 30+ curated prompts across 3 difficulty levels
- **A-Z Challenge** - Type all letters as fast as possible
- **Challenge Modes** - No Backspace, One Shot, Invisible Input
- **Live Statistics** - Real-time WPM, accuracy, and error tracking

### 🎨 Modern UI/UX
- **Glassmorphic Design** - Beautiful depth and transparency effects
- **Dark/Light Theme** - Automatic theme switching with smooth transitions
- **Responsive Layout** - Optimized for phones and tablets
- **Micro-interactions** - Smooth animations and feedback
- **Material 3** - Latest design system implementation

### ⚡ Performance
- **Fast Local Storage** - SharedPreferences for settings persistence
- **Efficient State Management** - Provider pattern for reactive UI
- **Optimized Animations** - Flutter Animate for smooth transitions
- **Lightweight** - Minimal dependencies, focused functionality

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.2.3)
- Android Studio / VS Code
- Android device or emulator

### Installation
```bash
# Clone the repository
git clone <repository-url>
cd typepro

# Install dependencies
flutter pub get

# Run the app
flutter run

# Build release APK
flutter build apk --release
```

## 🏗️ Architecture

### State Management
- **Provider Pattern** - Clean separation of concerns
- **AppState** - Centralized state for settings and game data
- **Reactive UI** - Automatic updates based on state changes

### File Structure
```
lib/
├── main.dart              # App entry point and theme configuration
├── screens/               # UI screens
│   ├── splash_screen.dart
│   ├── home_screen.dart
│   ├── game_screen.dart
│   ├── settings_screen.dart
│   └── result_screen.dart
├── state/
│   └── app_state.dart     # State management
└── assets/
    └── sentences.json     # Local prompt database
```

### Key Components
- **GameScreen** - Core typing logic with real-time statistics
- **SettingsScreen** - Theme and difficulty configuration
- **ResultScreen** - Animated performance display
- **Glassmorphic Cards** - Custom UI components with depth effects

## 🎮 Game Modes

### Sentence Practice
Practice with carefully curated prompts:
- **Easy**: 5-10 word sentences
- **Medium**: 10-15 word sentences  
- **Hard**: 15-20 word sentences

### Challenge Modes
- **No Backspace** - Cannot delete mistakes
- **One Shot** - Single mistake ends the test
- **Invisible Input** - Hide typed characters

### A-Z Challenge
Type the complete alphabet (a-z) as fast as possible.

## 📊 Statistics

Real-time tracking of:
- **Words Per Minute (WPM)** - Speed measurement
- **Accuracy** - Percentage of correct characters
- **Error Count** - Total mistakes made
- **Time Taken** - Duration in seconds

## 🛠️ Technical Details

### Dependencies
```yaml
dependencies:
  flutter: sdk
  provider: ^6.1.1          # State management
  shared_preferences: ^2.2.2 # Local storage
  flutter_animate: ^4.5.0    # Animations
  google_fonts: ^6.1.0       # Typography
  flutter_svg: ^2.0.9        # Vector graphics
```

### Performance Optimizations
- **Tree-shaking** - Removed unused code and assets
- **Efficient Rendering** - Optimized widget rebuilds
- **Memory Management** - Proper disposal of controllers and timers
- **Asset Optimization** - Compressed images and fonts

## 🎨 Design System

### Color Palette
- **Primary**: Modern blue gradients (#5A6BFF)
- **Surface**: Glassmorphic whites with transparency
- **Accent**: Blue accent for highlights and progress
- **Error**: Red accent for mistakes

### Typography
- **Google Fonts Inter** - Clean, modern typeface
- **Responsive Sizing** - Scales appropriately across devices
- **Weight Hierarchy** - Clear visual hierarchy

### Animations
- **Smooth Transitions** - 120ms micro-interactions
- **Progress Indicators** - Animated completion bars
- **Result Animations** - Staggered stat reveals
- **Theme Switching** - Seamless dark/light mode

## 📱 Platform Support

- **Android** - Full support with native performance
- **iOS** - Compatible (requires iOS deployment setup)
- **Web** - Responsive web version (experimental)
- **Desktop** - Windows, macOS, Linux support

## 🔧 Development

### Code Quality
- **Flutter Lints** - Enforced code style and best practices
- **Provider Pattern** - Clean architecture principles
- **Null Safety** - Full Dart null safety implementation
- **Documentation** - Comprehensive code comments

### Testing
```bash
# Run tests
flutter test

# Analyze code
flutter analyze

# Format code
flutter format .
```

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📞 Contact

For questions or feedback, please open an issue on GitHub.

---

Built with ❤️ using Flutter and modern development practices.
