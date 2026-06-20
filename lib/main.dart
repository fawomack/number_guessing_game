// Imports Flutter's UI framework packages (contains all layout blocks like Buttons, Columns, and Colors)
import 'package:flutter/material.dart';

// Imports your custom home screen file so this script can launch it as the starting window
import 'screens/main_menu_screen.dart';

// The absolute entry point of the application. The computer targets this function first when booting up.
void main() {
  // Launches the core Flutter layout engine and mounts your custom master widget (MyApp) onto the screen
  runApp(const MyApp());
}

// MyApp is a StatelessWidget because its core engine settings never dynamically switch values while running
class MyApp extends StatelessWidget {
  // Constructor rule that optimizes memory management when rendering this widget tree hierarchy
  const MyApp({super.key});

  // The build method serves as the layout designer template that draws everything on the execution thread
  @override
  Widget build(BuildContext context) {
    // MaterialApp wraps your app in foundational configurations like navigation routes, titles, and localized fonts
    return MaterialApp(
      title: 'Guessing Game', // Operating system task label
      debugShowCheckedModeBanner: false, // Hides the bright red "DEBUG" banner from Chrome's top right corner
      
      // 🌟 THE GLOBAL MASTER CONFIGURATION
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF003D82), // Universal background color (Midnight Blue)
        
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF003D82), // Base anchor color used to generate consistent color accents
          secondary: const Color(0xFFFF8C00), // Universal secondary accent color (Deep Orange)
        ),

        // This instantly formats EVERY primary solid ElevatedButton used anywhere across your application files
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF8C00), // Primary solid button background color
            foregroundColor: Colors.white, // Text color inside solid buttons
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Bold global typography scaling
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Button corner roundness radius
          ),
        ),

        // This instantly formats EVERY Outlined border style button used across your application files
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.white, width: 2), // Outlined frame color and line thickness
            foregroundColor: Colors.white, // Text color inside hollow buttons
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Matches bold primary sizing
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Matches button corner curves
          ),
        ),
      ),
      
      // Directs the app's internal navigation system on which file layout screen component to draw as the home page
      home: const MainMenuScreen(),
    );
  }
}