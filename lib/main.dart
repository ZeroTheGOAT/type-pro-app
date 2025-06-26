import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/game_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/result_screen.dart';
import 'state/app_state.dart';

void main() {
  runApp(const TypeProApp());
}

class TypeProApp extends StatelessWidget {
  const TypeProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: Consumer<AppState>(
        builder: (context, appState, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'TypePro',
            themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            theme: _buildTheme(Brightness.light),
            darkTheme: _buildTheme(Brightness.dark),
            initialRoute: '/',
            routes: {
              '/': (context) => const SplashScreen(),
              '/home': (context) => const HomeScreen(),
              '/game': (context) => const GameScreen(),
              '/settings': (context) => const SettingsScreen(),
              '/result': (context) => const ResultScreen(),
            },
          );
        },
      ),
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return ThemeData(
      brightness: brightness,
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: isDark ? const Color(0xFF7F8CFF) : const Color(0xFF5A6BFF),
        onPrimary: Colors.white,
        secondary: isDark ? const Color(0xFFB2B8FF) : const Color(0xFFB2B8FF),
        onSecondary: Colors.black,
        error: Colors.redAccent,
        onError: Colors.white,
        background: isDark ? const Color(0xFF181A20) : const Color(0xFFF6F8FF),
        onBackground: isDark ? Colors.white : Colors.black,
        surface: isDark ? const Color(0xFF23263A) : Colors.white.withOpacity(0.8),
        onSurface: isDark ? Colors.white : Colors.black,
      ),
      textTheme: GoogleFonts.interTextTheme(
        isDark ? ThemeData.dark().textTheme : ThemeData.light().textTheme,
      ),
      scaffoldBackgroundColor: isDark ? const Color(0xFF181A20) : const Color(0xFFF6F8FF),
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? const Color(0xFF23263A).withOpacity(0.7) : Colors.white.withOpacity(0.7),
        elevation: 0,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
        titleTextStyle: GoogleFonts.inter(
          color: isDark ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      cardTheme: CardThemeData(
        color: isDark ? Colors.white.withOpacity(0.05) : Colors.white.withOpacity(0.7),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        shadowColor: isDark ? Colors.black54 : Colors.blueGrey.withOpacity(0.2),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? Colors.white.withOpacity(0.04) : Colors.white.withOpacity(0.7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all(isDark ? Colors.white : Colors.blueAccent),
        trackColor: MaterialStateProperty.all(isDark ? Colors.blueGrey : Colors.blueAccent.withOpacity(0.3)),
      ),
    );
  }
}
