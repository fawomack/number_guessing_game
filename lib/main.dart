import 'package:flutter/material.dart';
import 'screens/main_menu_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guessing Game',
      debugShowCheckedModeBanner: false, 
      
      // 🌟 THE GLOBAL MASTER CONFIGURATION
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF003D82), // Universal Background Color
        
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF003D82),
          secondary: const Color(0xFFFF8C00), // Universal Orange Accent Color
        ),

        // FIXED: Swapped out the typo for the valid standard styleFrom builder
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF8C00), 
            foregroundColor: Colors.white, 
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),

        // This instantly formats EVERY Outlined white button in the app!
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.white, width: 2), 
            foregroundColor: Colors.white, 
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
      home: const MainMenuScreen(),
    );
  }
}